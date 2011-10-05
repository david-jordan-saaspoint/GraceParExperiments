# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_demo3_session',
  :secret      => '0206d2def22849ad3595b1f72bef362b112181efb20ff9f70dd05fb0f69f2b1da6803ef924401d5897bc014975d741629aaa88cc3692f63ffbc1bdb9bbef8035'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
