class AddDueColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :due, :boolean, default: false
  end
end
