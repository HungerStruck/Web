class Player
  include Mongoid::Document
  has_many :matches
  belongs_to :user

  field :died_at, type: Date

  field :kills,                 type: Integer, default: 0
  field :deaths,                type: Integer, default: 0
end
