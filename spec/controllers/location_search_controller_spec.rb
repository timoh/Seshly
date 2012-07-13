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
  		      'email' => 'bob@example.com',
  		      'nickname' => 'bobbieb'
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
    
    it "should be able to submit form" do
      Fetchvenue.stub(:generate_access_token).and_return('FZA235ZWUS3ETFPZC5PXUYEFZRDOMYINFEGZOZPE5VXW5AQV')
      user = User.first
      user.foursq_token = 'FZA235ZWUS3ETFPZC5PXUYEFZRDOMYINFEGZOZPE5VXW5AQV'
      user.save!
      Fetchvenue.stub!(:with_id)

      visit "/location_search"
      page.should have_content(User.first.nickname)
      page.should have_field('location')
      page.fill_in 'location', :with => 'Kiasma'
      
      page.click_button 'Submit'
      
      puts page.to_s 
      page.should have_content('Results')
      page.should have_content('Kiasma')
    end 
    
    xit "should make sure database query is sanitized"
    
    xit "should check that @locations is an array containing location objects"
    
  end

end
