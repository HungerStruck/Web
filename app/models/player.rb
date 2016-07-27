class Player
  include Mongoid::Document
  has_many :matches
  belongs_to :user

  field :died_at, type: Date
end
