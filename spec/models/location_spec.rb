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