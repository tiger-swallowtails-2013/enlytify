require_relative '../../config.rb'

class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk
end 
