json.extract! reminder, :id, :title, :description, :datetime, :price, :recurrence, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
