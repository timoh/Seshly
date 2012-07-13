#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'
require 'rspec/mocks'

describe LocationSearchController do
  
  # after(:each) do
  #   if example.exception
  #     save_and_open_page 
  #   end
  # end
  
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
  		  
  		user = User.first
      user.foursq_token = 'FZA235ZWUS3ETFPZC5PXUYEFZRDOMYINFEGZOZPE5VXW5AQV'
      user.save!
               
      # venue_hash = {
      #   
      #   "venue" => {
      #     
      #     "id"=> "4bd424b5b221c9b63b15dbd0", 
      #     "name"=> "Eläintarhan skeittipuisto, Micropolis Skate Park", 
      #     
      #     "location"=> {
      #       "address"=>"Nordenskiöldinkatu", 
      #       "crossStreet"=>"Hammarskjöldintie",
      #       "lat"=>60.191882003178755,
      #       "lng"=>24.92883083314635,
      #       "postalCode"=>"00250",
      #       "city"=>"Helsinki",
      #       "country"=>"Finland",
      #       "cc"=>"FI"
      #     }  
      #   }
      # }
      
      # Fetchvenue.stub!(:with_keyword).and_return(venue_hash)
    end
   
    it "should include have title and search form" do
      visit "/location_search"
      page.should have_content('Location Search')
      page.should have_content('Submit')
      page.should have_field('location')
    end 
    
    it "should be able to submit form" do
      visit "/location_search"  
      page.should have_field('location')
      
      page.fill_in 'location', :with => 'Kiasma'
      page.click_button 'Submit'
      
      page.should have_content('Results')
      page.should have_content('Kiasma')
    end 
      
    xit "should check that @locations is an array containing location objects" do
      new_location = FactoryGirl.create(:location, :name => 'Kiasma')
      Fetchvenue.stub!(:with_id)
      
      visit "/location_search"
      page.fill_in 'location', :with => 'Kiasma'
      page.click_button 'Submit'
      
      page.should have_content('Kiasma')
    end
    
    xit "should make sure database query is sanitized"
    
  end

end
