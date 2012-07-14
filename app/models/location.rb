class Location
  include Mongoid::Document
  include Mongoid::Timestamps
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
  
  has_many :posts

  def gmaps_address
    "#{self.street_address}, #{self.city}, #{self.country}" 
  end
  
end
