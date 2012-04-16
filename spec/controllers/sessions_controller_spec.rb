require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end
  describe "GET 'signin'" do
    it "should get signin" do
      get 'signin'
      response.should be_success
    end
  end

  describe "GET 'signout'" do
    it "should get signout" do
      get 'signout'
      response.should be_success
    end
  end
end