class Map
  include Mongoid::Document
  has_many :matches

  field :name, type: String
  field :background_image, type: String
end
