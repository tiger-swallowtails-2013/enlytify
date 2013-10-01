require_relative '../../config.rb'

class User < ActiveRecord::Base
  has_many :notes
  has_many :talks
end 
