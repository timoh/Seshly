class Fetchvenue
  
  
  def self.with_id(venue_id, access_token)
    foursquare = Foursquare::Base.new(access_token)
    venue = foursquare.venues.find(venue_id)
     
    return venue
  end
  
  def self.with_keyword(keyword, access_token)
    foursquare = Foursquare::Base.new(access_token)
    output = foursquare.venues.search(:ll => '44.3,37.2', :near => "Helsinki, Finland", :query => "#{keyword}", :oauth_token => access_token)
    return output['places']
  end
  
  def self.generate_access_token(callback_code)
    foursquare = Foursquare::Base.new(ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET'])
    return foursquare.access_token(callback_code, ENV['DOMAIN_URL']+"/location_search/")
  end
  
end
