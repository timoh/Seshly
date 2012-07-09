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
      visit root_path
      page.should have_content("Posts")
    end
  end
  
  describe "when a user is not logged in" do
    it "should encourage to sign up by redirecting to signup when user tries to create a new post"
    
  end

end
