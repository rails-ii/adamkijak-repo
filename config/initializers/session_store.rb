# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CeeMeS_session',
  :secret      => '1673efec972c6dfd40f911f6d7f2769d3bb1297a4d31d9d6cce1ef0c709f311bde4ab28cf3b93923d13be22bcb98ce1ed3d88d774d8b42f09b9458e52074df42'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
