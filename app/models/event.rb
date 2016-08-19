class Event
  include Mongoid::Document
  include GlobalID::Identification
  belongs_to :game
  belongs_to :player
  belongs_to :killer, :class_name => 'Player'
  
  field :time, type: DateTime
  field :type, type: String

  after_create { EventRelayJob.perform_later(self) }
end