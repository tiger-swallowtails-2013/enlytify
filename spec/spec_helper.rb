$LOAD_PATH.unshift(File.expand_path(__FILE__))
ENV['RACK_ENV'] ||= 'test'
require "rack/test"
require 'rspec'
require 'capybara/rspec'

require_relative "../app/app"
require_relative '../app/models/note'
require_relative '../app/models/user'
require_relative '../app/models/talk'
ENV['DBC_API'] = 'adf1bddb9ce560351173ef3a19a288aa'



module FeatureSpec
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.before do
    Talk.destroy_all
    Note.destroy_all
  end
end

def login_as(user)
  OmniAuth.config.mock_auth[:dbc] = OmniAuth::AuthHash.new({
    :provider => 'dbc',
    :uid => user.dbc_student_id,
    :info => {:fullname => 'Morgan Wildermuth'},
    :credentials => {:token => '4e0f37c9ebcb3b24247f2fdbb637eb81'}
  })
  visit '/auth/dbc'
end

Capybara.app = Sinatra::Application
