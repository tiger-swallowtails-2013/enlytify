require 'spec_helper'
enable :sessions

# def login_as(user)
#   OmniAuth.config.add_mock(:dbc, { dbc_student_id: user.dbc_student_id })
# end
feature "authenticated user" do
  # before do
  #   OmniAuth.config.add_mock(:dbc, { dbc_student_id: user.dbc_student_id })
  # end
  scenario "can see authenticated content on the talk page" do
    user = User.new({dbc_student_id: 1, id: 1})
    @talk = Talk.create
    @talk.id = 1
    get '/talk/1', {},'rack.session' => {dbc_student_id: 1, id: 2, email: "lionelramos@lionel.com"}
    (page.body).should_not include "Not authenticated"
  end
end
