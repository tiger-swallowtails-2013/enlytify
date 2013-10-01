require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require 'omniauth-github'

ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")

configure do
  enable :sessions
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,gist"
  end
end
get '/' do
  erb :index
end

get '/sign_in' do
  redirect to ('/auth/github')
end


get '/auth/:provider/' do
  user_attributes = request.env['omniauth.auth'].info
  session[:user_attributes] = user_attributes
  token = request.env['omniauth.auth'].credentials
  session[:oauth_token] = token_as_hash(token)
  redirect to ('/')
end
