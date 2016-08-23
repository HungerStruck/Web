class Player
  include Mongoid::Document
  has_many :events
  has_and_belongs_to_many :games

  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable
  
  field :username,  type: String
  field :uuid,      type: String

  field :background_image,      type: String, default: "default"

  def forum_display_name
    username
  end

  def kills
    Event.where(killer: self).count
  end

  def deaths
    self.events.count
  end
end
