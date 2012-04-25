require 'spec_helper'

describe "diets/new.html.haml" do
  before(:each) do
    assign(:diet, stub_model(Diet,
      :user_id => 1,
      :items => 1,
      :food_consumed => "MyString",
      :serving => 1,
      :calories => 1,
      :sodium => 1,
      :total_fruit_serving => 1,
      :total_vegetable_serving => 1,
      :water => 1
    ).as_new_record)
  end

  it "renders new diet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => diets_path, :method => "post" do
      assert_select "input#diet_user_id", :name => "diet[user_id]"
      assert_select "input#diet_items", :name => "diet[items]"
      assert_select "input#diet_food_consumed", :name => "diet[food_consumed]"
      assert_select "input#diet_serving", :name => "diet[serving]"
      assert_select "input#diet_calories", :name => "diet[calories]"
      assert_select "input#diet_sodium", :name => "diet[sodium]"
      assert_select "input#diet_total_fruit_serving", :name => "diet[total_fruit_serving]"
      assert_select "input#diet_total_vegetable_serving", :name => "diet[total_vegetable_serving]"
      assert_select "input#diet_water", :name => "diet[water]"
    end
  end
end
