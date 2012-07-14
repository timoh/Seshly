require 'spec_helper'

describe HomeController do
  
  before do
    
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "content" do
    it "should include posts" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:post, :user => user)
      visit root_path
      page.should have_content("sessions")
    end
  end

end
