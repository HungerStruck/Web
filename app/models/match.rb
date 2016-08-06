class Match
  include Mongoid::Document
  has_many :events
  has_many :users
  belongs_to :map

  field :started_at, type: Date
  field :ended_at, type: Date

  field :map,  type: String # will be map object eventually
  field :server, type: String # e.g hs7

end
