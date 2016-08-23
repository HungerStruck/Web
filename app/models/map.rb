class Map
  include Mongoid::Document
  has_many :games
  
  field :name, type: String
end
