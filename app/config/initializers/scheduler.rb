# REMOVE
require 'rufus-scheduler'
SCHEDULER = Rufus::Scheduler.singleton

# Rails.application.config.after_initialize do
SCHEDULER.in '5s' do
  Reminder.all.each do |r|
    next_run = r.datetime
    if next_run < Time.now
      next_run += (Time.now.change(sec: 0) - next_run).floor + 1.send(r.recurrence)
    end
    Rails.logger.info "Setting scheduler for reminder #{r.id}, at #{r.datetime} to start_at: #{next_run}"
    p "Setting scheduler for reminder #{r.id}, at #{r.datetime} to start_at: #{next_run}"
    job = SCHEDULER.every RecurrenceHelper.recurrence_2_cron(r.recurrence), first_at: next_run do
      Rails.logger.info "Updating reminder #{r.id}, #{r.recurrence}"
      puts "Updating reminder #{r.id}, #{r.recurrence} to due: TRUE"
      rem = Reminder.find(r.id)
      rem.update!(due: true)
    end
    r.update!(scheduler: job)
  end
end
