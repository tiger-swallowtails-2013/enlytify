require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require 'omniauth-dbc'
require 'dotenv'
require_relative '../config'

Dotenv.load('.env')

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

  def date_format(date)
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    date_array = date.scan(/../)
    month = months[date_array[0].to_i-1]
    day = date_array[1]
    year = date_array[2] + date_array[3]
    @formatted_date = "#{month} #{day}, #{year}"
  end
end

get '/' do
  erb :index
end

get '/dashboard/:date' do
  if authenticated?
    @date = params[:date].to_date
    @days_talks = Talk.where("date = ?", params[:date])
    erb :dashboard
  else
    "Not authenticated"
  end
end

post '/talk/:id' do
  @talk = Talk.find(params[:id])
  @talk.resources = params[:resources]
  @talk.description = params[:desc]
  @talk.save
  erb :talk_show
end

get '/talk/:id' do 
  if authenticated?
    @talk = Talk.find(params[:id])
    erb :talk
  else
    "Not authenticated"
  end
end 



get '/sign_in' do
  redirect to ('/auth/dbc')
end

get '/auth/:provider/callback' do 
  user_attributes = request.env['omniauth.auth'].info
  p user_attributes
  p '*'*200
  session[:user_attributes] = user_attributes
  token = request.env['omniauth.auth'].credentials
  session[:oauth_token] = token_as_hash(token)
  p'/'*200
  p session
  @date = Time.now.to_date
  redirect to ("/dashboard/#{@date}")
end

get '/sign_out' do
  session.clear
  redirect to ('https://auth.devbootcamp.com')
end
