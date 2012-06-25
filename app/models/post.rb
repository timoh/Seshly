class Post
  include Mongoid::Document
  field :description, :type => String
  field :short_url, :type => String
  
  belongs_to :location
  belongs_to :user
  
  validates_associated :user
  
end
