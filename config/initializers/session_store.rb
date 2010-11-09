# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_besttables_session',
  :secret      => '5084236340a190cf6343699ae5acd72f1bf3a295c3672a3a495c071e04ef0643c9a8b3f595e6d9773c05018924aaf142e3c0174c6e859de5a4b00daac193fd7e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
