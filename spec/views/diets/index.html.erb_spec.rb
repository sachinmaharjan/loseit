require 'spec_helper'

describe "diets/index.html.erb" do
  before(:each) do
    assign(:diets, [
      stub_model(Diet,
        :user_id => 1,
        :items => 1,
        :food_consumed => "Food Consumed",
        :serving => 1,
        :calories => 1,
        :sodium => 1,
        :total_fruit_serving => 1,
        :total_vegetable_serving => 1,
        :water => 1
      ),
      stub_model(Diet,
        :user_id => 1,
        :items => 1,
        :food_consumed => "Food Consumed",
        :serving => 1,
        :calories => 1,
        :sodium => 1,
        :total_fruit_serving => 1,
        :total_vegetable_serving => 1,
        :water => 1
      )
    ])
  end

  it "renders a list of diets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Food Consumed".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
