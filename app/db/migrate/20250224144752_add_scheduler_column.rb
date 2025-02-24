class AddSchedulerColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :scheduler, :string
  end
end
