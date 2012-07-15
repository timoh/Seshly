require 'spec_helper'

describe Location do
  
  describe 'search with name' do
    
    before do
      search_term = "Ponke"
      @original_location = FactoryGirl.create(:location, name: "Ponke's")
      @location = Location.where(name: "Ponke's").first
    end
    
    it 'should fetch the same object' do
      @location.should == @original_location
    end
    
    describe 'geolocation' do
      
      it 'should return coordinates' do
        location = FactoryGirl.create(:location, :lat => 20.0, :lng => 30.0)
        location.coordinates[0].should == 20.0
        location.coordinates[1].should == 30.0
      end
      
      it 'should return address' do
        location = FactoryGirl.create(:location, :street_address => 'Helsinginkatu 10', :city => 'Helsinki', :country => 'Finland')
        location.address.should == 'Helsinginkatu 10, Helsinki, Finland'
      end
      
      
    end
    
    describe 'and regexp' do
      
      before do
        search_term = "Ponke"
        @original_location = FactoryGirl.create(:location, name: "Ponke's")
        @location = Location.where(name: /#{search_term}/i).first
      end
        
      it 'should not be nil' do
        @location.should_not be_nil
      end

      it 'should match names' do      
        @location.name.should == "Ponke's"
      end
      
    end
  
  end
  
end