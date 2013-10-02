require_relative "spec_helper"


describe "associations" do 
  before(:each) do
    @current_user = User.new({'name' => 'Morgan Wildermuth', 'email' => "morgan.wildermuth@gmail.com", 'gravatar' => "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", 'id' => 633})
    p @current_user
    @talk = Talk.create
    @talk.user_id = @current_user.dbc_student_id
  end #before
  context "when we create a note" do  
    before(:each) do 
      @note = @talk.notes.create   
      @note.user_id = @current_user.dbc_student_id
      p @note                                                  
    end 

    it "should have a talk_id" do 
      expect(@note.talk_id).to be_a_kind_of(Integer) 
      p @note   
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

