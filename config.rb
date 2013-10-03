require 'dotenv'
require 'sinatra/activerecord'
require 'dbc-ruby'
Dotenv.load('.env')
require_relative 'app/models/note'
require_relative 'app/models/user'
require_relative 'app/models/talk'

DBC.token = ENV['DBC_API']


ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")
