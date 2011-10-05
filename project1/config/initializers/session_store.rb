# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_project1_session',
  :secret      => '5fe303feaa9e5332df62fc59fb99c43c02383c7a035260e3fdcbb8ca5bb3b2b8d4f5b143149539744c741eb3d8db8b2ad7e8d6c973742c70f4e3c3fd6ca722aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
