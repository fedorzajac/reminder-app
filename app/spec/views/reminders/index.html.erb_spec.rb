require 'rails_helper'

RSpec.describe "reminders/index", type: :view do
  before(:each) do
    assign(:reminders, [
      Reminder.create!(
        title: "Title",
        description: "MyText",
        price: "9.99",
        recurrence: 2
      ),
      Reminder.create!(
        title: "Title",
        description: "MyText",
        price: "9.99",
        recurrence: 2
      )
    ])
  end

  it "renders a list of reminders" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
