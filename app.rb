# require 'sinatra'
# require 'sinatra/activerecord'

# ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
# ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")


# get '/' do
#   "Hello world"
# end

require 'dbc-ruby'
require_relative 'config'

DBC.token = TOKEN

p DBC::User.find(25)