require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    assign(:player, Player.new(
      :slack_name => "MyString",
      :slack_id => "MyString",
      :active_game => 1
    ))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", players_path, "post" do

      assert_select "input[name=?]", "player[slack_name]"

      assert_select "input[name=?]", "player[slack_id]"

      assert_select "input[name=?]", "player[active_game]"
    end
  end
end
