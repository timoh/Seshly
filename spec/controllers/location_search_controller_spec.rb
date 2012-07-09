require 'spec_helper'
require 'rspec/mocks'

describe LocationSearchController do
  
  describe "visiting index should result in successful response" do
    it "returns http success" do
      visit "/location_search"
      response.should be_success
    end
  end
  
  describe "once correctly signed in" do  
    
    before do
        OmniAuth.config.mock_auth[:twitter] = {
  		    'uid' => '12345',
  		    'provider' => 'twitter',
  		    'info' => {
  		      'name' => 'Bob',
  		      'email' => 'bob@example.com'
  		    }
  		  }
  		  
  		  visit "/auth/twitter"
    end
    
    after(:each) do
      if example.exception
        #save_and_open_page 
      end
    end
    
    it "should include have title and search form" do
      visit "/location_search"
      page.should have_content('Location Search')
      page.should have_content('Submit')
      page.should have_field('location')
    end 
    
    xit "should be able to submit form" do
      Fetchvenue.stub!(:generate_access_token)
      Fetchvenue.stub!(:with_id)

      visit "/location_search"
      page.should have_field('location')
      page.fill_in 'location', :with => 'Kiasma'
      page.click_button 'Submit'
      params[:code] == 'mock'
      
      puts page.to_s 
      page.should have_content('Results')
      page.should have_content('Kiasma')
    end 
  end

end
