class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, :type => String
  field :short_url, :type => String
  
  belongs_to :location
  belongs_to :user
  
  validates_associated :user
  validates_uniqueness_of :short_url
  validates_presence_of [:description, :user]
  
end
