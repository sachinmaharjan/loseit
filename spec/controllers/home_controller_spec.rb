require 'spec_helper'

describe HomeController do
  describe "GET 'home'" do
    it "should get index" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'about us'" do
    it "should get about us" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'donate'" do
    it "should get donate" do
      get 'donate'
      response.should be_success
    end
  end
  describe "GET 'shots'" do
    it "should get shots" do
      get 'shots'
      response.should be_success
    end
  end
  describe "GET 'contact'" do
    it "should get contact" do
      get 'contact'
      response.should be_success
    end
  end
end

