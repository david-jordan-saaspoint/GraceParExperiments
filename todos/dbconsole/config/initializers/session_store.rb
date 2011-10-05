# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dbconsole_session',
  :secret      => '7b8155d5fb06c80c0c2a407dcea934cd7f55bd29c4e39451f8156fe1329c1de022a0da4232cea54cc3441e72ec3d5f4dca1df2007b3c9459767ec6040ccb2621'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
