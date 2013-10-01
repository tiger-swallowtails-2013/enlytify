require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require 'omniauth-dbc'
require 'dotenv'


Dotenv.load('.env')
ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")

configure do
  enable :sessions
  use OmniAuth::Builder do
    provider :dbc, ENV['OAUTH_TOKEN'], ENV['OAUTH_SECRET']
  end
end

helpers do
  def authenticated?
    !session[:oauth_token].nil?
  end

  def current_user
    @current_user ||= User.new(session[:user_attributes])
  end

  def token_as_hash(token)
    {token: token.token,
      refresh_token: token.refresh_token,
      expires_at: token.expires_at
    }
  end
end


get '/' do
  erb :index
end

get '/test' do
  if authenticated?
    "Hello World"
  else
    "Not authenticated"
  end
end

get '/sign_in' do
  redirect to ('/auth/dbc')
end


get '/auth/:provider/callback' do
  user_attributes = request.env['omniauth.auth'].info
  session[:user_attributes] = user_attributes
  token = request.env['omniauth.auth'].credentials
  session[:oauth_token] = token_as_hash(token)
  redirect to ('/test')
end

get '/sign_out' do
  session.clear
  redirect to ('https://auth.devbootcamp.com')
end
