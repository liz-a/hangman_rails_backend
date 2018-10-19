require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    assign(:players, [
      Player.create!(
        :slack_name => "Slack Name",
        :slack_id => "Slack",
        :active_game => 2
      ),
      Player.create!(
        :slack_name => "Slack Name",
        :slack_id => "Slack",
        :active_game => 2
      )
    ])
  end

  it "renders a list of players" do
    render
    assert_select "tr>td", :text => "Slack Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slack".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
