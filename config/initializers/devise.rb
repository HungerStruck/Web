Devise.setup do |config|
  config.mailer_sender = 'noreply@hungerstruck.net'
  require 'devise/orm/mongoid'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.reconfirmable = true

  config.skip_session_storage = [:http_auth]
  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
