class LocationSearchController < ApplicationController
  
  def index
    
    foursquare = Foursquare::Base.new("MWLS2YVYIYJ3DN4JTXGU0IKRF0PHQB3DZIC1JBILWDIB2LLU", "5JQHJJGE3CDJ2ZXDDFG0WWWF0TUZNC2BYHY3KMLXDY2X5PWE")
    
    if params[:location] && !params[:code]
      redirect_to foursquare.authorize_url("http://sesh-ly.herokuapp.com/location_search/")
    end
    
    if params[:location] && params[:code]
      access_token = foursquare.access_token(params["code"], "http://sesh-ly.herokuapp.com/location_search/")
      foursquare = Foursquare::Base.new(access_token)
      @location = Location.where(name: "#{params[:location]}")
    end
  end
  
end
