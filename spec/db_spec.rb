require_relative "spec_helper"


describe "associations" do 
  before(:each) do 
    @current_user = User.create(fullname: 'bobby')
    @talk = @current_user.talks.create
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

describe "sinatra routes" do
  include FeatureSpec

  context "when we got to the talk page" do 
    it "should include a talk title" do 
      get '/user/:id/talk/:id'
      expect(last_response.body).to include "Backbone"
    end #it
  end #context
end #describe

