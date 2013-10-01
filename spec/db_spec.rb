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
    @talk = @user.talks.create
  end #before
  context "when we create a note" do  
    before(:each) do 
      @note = @talk.notes.create   
      @note.user_id = @talk.user_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    end 

    it "should have a talk_id" do 
      expect(@note.talk_id).to be_a_kind_of(Integer)    
    end #it
    it "should have a user_id" do 
      expect(@note.user_id).to be_a_kind_of(Integer)
    end #it 
  end #context  

  context "when we create a talk" do 
    it "should have a user_id" do
      expect(@talk.user_id).to be_a_kind_of(Integer)     
    end #it
  end #context
end #describe

