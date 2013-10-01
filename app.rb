# require 'sinatra'
# require 'sinatra/activerecord'
require 'dbc-ruby'
require_relative 'config'
require 'ap'

# ENV['RACK_ENV'] == 'test' ? DB_NAME = "enlytifydb_test" : DB_NAME = "enlytifydb"
# ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgresql://localhost/#{DB_NAME}")


# get '/' do
#   "Hello world"
# end


me = 'Sunny Israni'

DBC.token = TOKEN
# p DBC::User.all[0].name


def find_by_name(full_name)
	DBC::User.all.each do |user|
		return user if user.name == full_name
	end
end

def gh_id(user)
  user.profile[:github].gsub(/https:\/\/github.com\//,'')

end

def find_user(gh_id)
  gh_url = 'https://github.com/' + gh_id
  DBC::User.all.each do |user|
    return user if user.profile[:github] == gh_url
  end

end

p find_user('SunnyIzr')