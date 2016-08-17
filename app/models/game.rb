class Game
  include Mongoid::Document
  has_many :events
  has_many :players

  field :started_at, type: DateTime
  field :ended_at, type: DateTime

  field :map,  type: String # will be map object eventually
  field :server, type: String # e.g hs7
end
