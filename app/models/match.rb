class Match
  include Mongoid::Document
  include Mongoid::Timestamps

  field :state, type: Symbol # either :playing or :ended

  field :map,  type: String # will be map object eventually
  field :server, type: String # e.g hs7

end
