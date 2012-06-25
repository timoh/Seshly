class LocationSearchController < ApplicationController
  
  def index
    if current_user 
      foursquare = Foursquare::Base.new("MWLS2YVYIYJ3DN4JTXGU0IKRF0PHQB3DZIC1JBILWDIB2LLU", "5JQHJJGE3CDJ2ZXDDFG0WWWF0TUZNC2BYHY3KMLXDY2X5PWE")
    
      if params[:location] && !params[:code]
        redirect_to foursquare.authorize_url("http://sesh-ly.herokuapp.com/location_search/")
      end
    
      if params[:location] && params[:code]
        current_user.foursq_token = foursquare.access_token(params["code"], "http://sesh-ly.herokuapp.com/location_search/")
        foursquare = Foursquare::Base.new(current_user.foursq_token)
        @fsq_locs = foursquare.venues.search(:near => "Helsinki, Finland", :query => "#{params[:location]}") # Returns all resulting groups
        @location = Location.where(name: "#{params[:location]}")
      end
    else
      redirect_to '/signin'
  end
  
end
