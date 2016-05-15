class Match
  include Mongoid::Document

  field :time, type: Date
  field :state, type: Symbol # either :playing or :ended

  field :map,  type: String # will be map object eventually
  field :server, type: String # e.g hs7

end
