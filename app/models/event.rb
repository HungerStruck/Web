class Event
  include Mongoid::Document
  include GlobalID::Identification
  belongs_to :match
  belongs_to :user
  belongs_to :killer, :class_name => 'User'
  
  field :time, type: Date
  field :type, type: String

  field :type, type: String
  field :type, type: String


  after_create { EventRelayJob.perform_later(self) }
end