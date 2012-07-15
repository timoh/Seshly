class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Geocoder::Model::Mongoid
  # geocoded_by :address, :latitude => :lat, :longitude => :lng, :skip_index => true # can also be an IP address
  #after_validation :geocode          # auto-fetch coordinates
  
  
  field :name, :type => String
  field :foursq_id, :type => String
  field :description, :type => String
  field :url_to_fsq, :type => String
  field :street_address, :type => String
  field :cross_street, :type => String
  field :city, :type => String
  field :state, :type => String
  field :postal_code, :type => String
  field :country, :type => String
  field :lat, :type => Float
  field :lng, :type => Float
  
  # for geocoding, return an array of coordinates
  def coordinates
    coordinates = Array.new
    
    coordinates.push self.lat
    coordinates.push self.lng
    
    return coordinates
  end
  
  # for reverse geocoding, return address
  def address
    address = "#{self.street_address}, #{self.city}, #{self.country}"
    
  end
  
  has_many :posts

  def gmaps_address
    "#{self.street_address}, #{self.city}, #{self.country}" 
  end
  
end
