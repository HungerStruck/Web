class Match
  include Mongoid::Document

  field :time, type: Date
  field :map,  type: String # will be map object eventually

end
