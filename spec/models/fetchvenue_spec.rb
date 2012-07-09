require 'spec_helper'

describe Fetchvenue do
  
  context "#with_id" do
    it "should respond to with_id" do
      Fetchvenue.should respond_to(:with_id)
    end  
  end
  
  context "#with_keyword" do
    it "should respond to with_keyword" do
      Fetchvenue.should respond_to(:with_keyword)
    end  
    
  end
  
  context "#generate_access_token" do
    it "should respond to generate_access_token" do
      Fetchvenue.should respond_to(:generate_access_token)
    end  
    
  end
  
end
