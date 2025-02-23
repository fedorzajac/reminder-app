class CreateReminders < ActiveRecord::Migration[7.2]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.datetime :datetime
      t.decimal :price
      t.integer :recurrence

      t.timestamps
    end
  end
end
