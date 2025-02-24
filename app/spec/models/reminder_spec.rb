require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe "scheduling" do
    # let(:reminder) { Reminder.new(title: "title", description: "description", datetime: 5.seconds.from_now, price: 100, recurrence: "minute") }

    xit "saves a reminder" do
      expect { reminder.save }.to change { Reminder.count }.by(1)
    end

    it "create a scheduler after new reminder" do
      p Time.now
      p SCHEDULER.jobs.count
      r = Reminder.new(title: "title", description: "description", datetime: 5.seconds.from_now, price: 100, recurrence: "minute")
      r.save
      p SCHEDULER.jobs.count

      SCHEDULER.jobs.each { |job| p job.next_time }
      sleep 20
      r.reload
      p r
      expect(r.due).to be_truthy
      # expect { reminder.save }.to change { Reminder.count }.by(1)
    end
  end
end
