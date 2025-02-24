
module RecurrenceHelper
  def self.recurrence_2_cron(recurrence)
    h={
      "minute" => "1m",
      "day" => "1d",
      "week" => "1w",
      "month" => "1M",
    }
    h[recurrence]
  end
end
