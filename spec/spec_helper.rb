ENV['RACK_ENV'] ||= 'test'
require "rack/test"
require 'rspec'

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
  config.before do
    Talk.destroy_all
    Note.destroy_all
  end
end
