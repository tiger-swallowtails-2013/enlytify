ENV['RACK_ENV']='test'

require 'rspec'
require_relative '../app/models/note'
require_relative '../app/models/user'
require_relative '../app/models/talk'
require_relative "../config"
require 'rack/test'


describe "associations" do 
  before(:each) do 
    @user = User.create
    @talk = Talk.create
  end #before
  context "when we create a note" do  
    before(:each) do 
      @note = Note.create
    end 

    it "should have a talk_id" do 
      @note.talk_id.should exist
    end #it
    it "should have a user_id" do 
    end #it 
  end #context  

  context "when we create a talk" do 
    it "should have a user_id" do 
    end #it
  end #context
end #describe

