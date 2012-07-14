require 'spec_helper'
describe VenuesController do

  context '#index' do
    
    describe "visiting index should result in successful response" do
      it "returns http success" do
        Fetchvenue.stub!(:with_id)
        visit "/venues.json?location=test&access_token=asdasd123123"
        response.should be_success
      end
    end
  end
  
end