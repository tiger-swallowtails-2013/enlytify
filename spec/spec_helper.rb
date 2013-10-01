ENV['RACK_ENV'] ||= 'test'

require "rack/test"
require 'rspec'

require_relative "../app/app"
require_relative '../app/models/note'
require_relative '../app/models/user'
require_relative '../app/models/talk'



module FeatureSpec
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end


RSpec.configure do |config|
  config.before do
    User.destroy_all
    Talk.destroy_all
    Note.destroy_all
  end
end
