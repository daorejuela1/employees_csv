require 'truemail'

Truemail.configure do |config|
  # Required parameter. Must be an existing email on behalf of which verification will be performed
  config.verifier_email = 'daorejuela1@outlook.com'
  config.smtp_safe_check = true
end
