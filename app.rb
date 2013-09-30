require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require_relative 'config'

ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")


get '/' do
  "Hello world"
end
