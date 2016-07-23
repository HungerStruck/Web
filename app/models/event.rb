class Event
  include Mongoid::Document
  include GlobalID::Identification
  
  field :content, type: String

  after_create { EventRelayJob.perform_later(self) }
end