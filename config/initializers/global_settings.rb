# # Enable/disable user registration
# ENABLE_USER_REGISTRATION = true
# 
# # Enable/disable user to request reset password
# ENABLE_REQUEST_RESET_PASSWORD = true
# 
# # From email address in mail for restore password 
# FROM_EMAIL_ADDRESS = "noreplay@besttables.pt"


configatron.configure_from_yaml("config/config.yml", :hash => Rails.env)
