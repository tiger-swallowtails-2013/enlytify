require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require_relative '../config'

get '/' do
  "Hello world"
end
