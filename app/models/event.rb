class Event
  include Mongoid::Document
  include GlobalID::Identification
  belongs_to :match
  
  field :content, type: String

  after_create { EventRelayJob.perform_later(self) }
end