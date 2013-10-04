require 'sinatra'
require 'sinatra/activerecord'
require 'dbc-ruby'
require 'omniauth-dbc'
require 'dotenv'
require 'gravatar-ultimate'
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

  def find_by_name(user_name)
    DBC::User.all.select {|user| user.name == user_name}[0]
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
    @paramdate = params[:date]
    @days_talks = Talk.where("date = ?", params[:date])
    @cohort_id = current_user.cohort_id
    erb :dashboard
  else
    "Not authenticated"
  end
end

post '/dashboard/:date/add_talk' do
  @date = params[:date]
  Talk.create(topic: params[:new_talk], speaker: params[:author], date:params[:date])
  redirect "/dashboard/#{@date}"
end

post '/talk/:id' do
  @talk = Talk.find(params[:id])
  @talk.resources = params[:resources]
  @talk.description = params[:desc]
  @talk.notes.create(text: params[:new_note], author_id: current_user.dbc_student_id)
  @author = params[:note_author_name]
  p @author
  @talk.save
  redirect to "/talk/#{@talk.id}"
end

get '/talk/:id' do
  @talk = Talk.find(params[:id])
  @user_email = find_by_name(Talk.find(params[:id]).speaker).email
  @grav_url = Gravatar.new(@user_email).image_url
  if current_user.dbc_student_id == @talk.speaker_id
    erb :talk
  else
    erb :talk_show
  end
end

get '/sign_in' do
  redirect to "/auth/dbc"
end

get '/auth/:provider/callback' do
  user_attributes = request.env['omniauth.auth'].info
  p user_attributes
  session[:user_attributes] = user_attributes
  token = request.env['omniauth.auth'].credentials
  session[:oauth_token] = token_as_hash(token)
  @date = Time.now.to_date
  redirect to "/dashboard/#{@date}"
end

get '/sign_out' do
  session.clear
  redirect to 'https://auth.devbootcamp.com'
end


