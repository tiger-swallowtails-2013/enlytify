require_relative "spec_helper"

describe "associations" do 
  before(:each) do
    @current_user = User.new({'name' => 'Morgan Wildermuth', 'email' => "morgan.wildermuth@gmail.com", 'gravatar' => "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", 'id' => 633})

    @talk = Talk.create
    @talk.speaker_id = @current_user.dbc_student_id
  end #before
  context "when we create a note" do  
    before(:each) do 
      @note = @talk.notes.create   
      @note.author_id = @current_user.dbc_student_id
                                        
    end 

    it "should have a talk_id" do 
      expect(@note.talk_id).to be_a_kind_of(Integer) 

    end #it
    it "should have a speaker_id" do 
      expect(@note.author_id).to be_a_kind_of(Integer)
    end #it 
  end #context  

  context "when we create a talk" do 
    it "should have a speaker_id" do
      expect(@talk.speaker_id).to be_a_kind_of(Integer)     
    end #it
  end #context
end #describe

describe "sinatra routes" do
  include FeatureSpec

  context "when we got to the talk page" do 
    it "should include a talk title" do 
      @talk = Talk.new
      @talk.id = 1
      @talk.topic = "Backbone"
      @talk.save
      get '/talk/1'
      expect(last_response.body).to include "Backbone"
    end #it
  end #context
end #describe

