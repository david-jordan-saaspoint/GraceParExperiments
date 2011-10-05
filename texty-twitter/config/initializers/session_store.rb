# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_texty-twitter_session',
  :secret      => 'e8a51807c1ec5b5a8514b7dbc8c1e474c38102f396050c91bcf4cd23ed5f07219a97157e6ebd64a8011db1cf4c930f61ecf18c2292354663286736f9bb601e24'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
