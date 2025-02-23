class Reminder < ApplicationRecord
  after_create_commit { broadcast_prepend_to "reminders" }
  after_update_commit { broadcast_replace_to "reminders" }
  after_destroy_commit { broadcast_remove_to "reminders" }
end
