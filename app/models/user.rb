class User
  include Mongoid::Document
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

<<<<<<< HEAD
  def forum_display_name
    email
  end
=======
  field :username,  type: String
  field :uuid,      type: String

  field :kills,                 type: Integer, default: 0
  field :deaths,                type: Integer, default: 0
  field :background_image,      type: Integer, default: 0
>>>>>>> 2.0
end
