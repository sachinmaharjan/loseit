require "spec_helper"

describe DietsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/diets" }.should route_to(:controller => "diets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/diets/new" }.should route_to(:controller => "diets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/diets/1" }.should route_to(:controller => "diets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/diets/1/edit" }.should route_to(:controller => "diets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/diets" }.should route_to(:controller => "diets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/diets/1" }.should route_to(:controller => "diets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/diets/1" }.should route_to(:controller => "diets", :action => "destroy", :id => "1")
    end

  end
end
