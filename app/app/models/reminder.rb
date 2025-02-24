class Reminder < ApplicationRecord
  after_create_commit { broadcast_prepend_to "reminders" }
  after_update_commit { broadcast_replace_to "reminders" }
  after_destroy_commit { broadcast_remove_to "reminders" }

  enum recurrence: RECURRENCE

  after_create :set_scheduler
  after_destroy :destroy_scheduler
  after_update :update_scheduler, if: :datetime_changed?

  # validates :title, presence: true
  # validates :description, presence: true
  validates :datetime, presence: true, unless: :time_in_past?, on: :create
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :recurrence, presence: true
  private

  def destroy_scheduler
    Rails.logger.info "Destroying scheduler for reminder #{self.id}"
    SCHEDULER.unschedule(self.scheduler)
  end

  def update_scheduler
    Rails.logger.info "Updating scheduler for reminder #{self.id}"
    SCHEDULER.unschedule(self.scheduler)
    set_scheduler
  end

  def time_in_past?
    if datetime.present? && datetime < Time.now
      errors.add(:datetime, "can't be in the past")
      return true
    end
  end

  # def recurrence_2_cron(recurrence)
  #   recurrence_2_cron = {
  #     "minute" => "1m",
  #     "day" => "1d",
  #     "week" => "1w",
  #     "month" => "1M",
  #   }
  #   recurrence_2_cron[recurrence]
  # end

  def set_scheduler
    Rails.logger.info "Setting scheduler for reminder #{self.id}, at #{self.datetime}"
    p "Setting scheduler for reminder #{self.id}, at #{self.datetime}, #{RecurrenceHelper.recurrence_2_cron(self.recurrence)}"
    job = SCHEDULER.every RecurrenceHelper.recurrence_2_cron(self.recurrence), first_at: self.datetime do
      Rails.logger.info "Updating reminder #{self.id}, #{self.recurrence}"
      puts "Updating reminder #{self.id}, #{self.recurrence} to due: TRUE"
      r = Reminder.find(self.id)
      r.update!(due: true)
    end
    p job
    Reminder.find(self.id).update!(scheduler: job)
  end
end
