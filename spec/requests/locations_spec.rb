require 'spec_helper'

describe "Locations" do
  
  context '#index' do
  
    describe 'when user is not signed in' do
    
      it 'should not show new location button' do
        visit '/locations'
        page.should_not have_content('New')
        page.should_not have_content('Edit')
        page.should_not have_content('Destroy')
      end
    
      it 'should not allow to create new' do
        visit '/locations/new'
        page.should have_content('You need to sign in')
      end
    
      it 'should not allow to edit' do
        location  = FactoryGirl.create(:location)
        visit '/locations/'+location.id.to_s+'/edit'
        page.should have_content('You need to sign in')
      end
    
    end
  
  
    describe 'when user is signed in' do
    
      before do
        visit '/auth/twitter'
      end
    
      it 'should have new button' do
        visit '/locations'
        page.should have_content('New')
      end
    
      describe 'when content exists' do
      
        before do
          FactoryGirl.create(:location)
        end
      
        it 'should have new location control' do
          visit '/locations'
          page.should have_content('New Location')
        end
      end
    
    end
    
  end
  
  context '#show' do
    
    before do
      post = FactoryGirl.create(:location)
    end
  
  
    describe 'when user is not signed in' do
      it 'should not show controls' do
        visit '/locations/'+Location.first.id.to_s
        page.should_not have_content('Edit')
      end
    end
    
    
    describe 'when user is signed in' do
      
      before do
        visit '/auth/twitter'
      end
      
      it 'should show controls' do
        visit '/locations/'+Location.first.id.to_s
        page.should have_content('Edit')
      end
      
    end
  
  end


end