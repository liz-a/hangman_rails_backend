require 'rails_helper'

RSpec.describe "players/show", type: :view do
  before(:each) do
    @player = assign(:player, Player.create!(
      :slack_name => "Slack Name",
      :slack_id => "Slack",
      :active_game => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Slack Name/)
    expect(rendered).to match(/Slack/)
    expect(rendered).to match(/2/)
  end
end
