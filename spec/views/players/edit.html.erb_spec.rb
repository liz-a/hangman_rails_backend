require 'rails_helper'

RSpec.describe "players/edit", type: :view do
  before(:each) do
    @player = assign(:player, Player.create!(
      :slack_name => "MyString",
      :slack_id => "MyString",
      :active_game => 1
    ))
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", player_path(@player), "post" do

      assert_select "input[name=?]", "player[slack_name]"

      assert_select "input[name=?]", "player[slack_id]"

      assert_select "input[name=?]", "player[active_game]"
    end
  end
end
