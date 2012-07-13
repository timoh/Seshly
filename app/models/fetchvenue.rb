class Fetchvenue
  
  
  def self.with_id(venue_id, access_token)
    raise 'empty venue_id for With ID' if venue_id == nil
    raise 'empty access_token for With ID' if access_token == nil
    foursquare = Foursquare::Base.new(access_token)
    venue = foursquare.venues.find(venue_id)
     
    return venue
  end
  
  def self.with_keyword(keyword, access_token)
    raise 'empty keyword for With Keyword' if keyword == nil
    raise 'empty access_token for With Keyword' if access_token == nil
    foursquare = Foursquare::Base.new(access_token)
    result = foursquare.venues.search(:ll => '44.3,37.2', :near => "Helsinki, Finland", :query => "#{keyword}", :oauth_token => access_token)
    return result['places']
  end
  
  def self.generate_access_token(callback_code)
    raise 'empty parameter for Generate Access Token' if callback_code == nil
    foursquare = Foursquare::Base.new(ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET'])
    access_token = foursquare.access_token(callback_code, ENV['DOMAIN_URL']+"/location_search/")
    return access_token
  end
  
end
  