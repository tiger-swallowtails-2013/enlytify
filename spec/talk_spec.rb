require 'spec_helper'

feature 'the current user is the author of the talk', :type => :feature do

  before :each do
    @talk = Talk.create
    @talk.id = 1
    @talk.save
    @current_user = User.new({fullname: 'Morgan Wildermuth', email: "morgan.wildermuth@gmail.com", gravatar: "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", id: 633, cohort_id: 29})
    visit("/talk/#{@talk.id}")
  end

  scenario 'shows the description form' do
    expect(page).to have_selector('#desc_form')
  end

  scenario 'shows the resource form' do
    expect(page).to have_selector('#resources_form')
  end

  scenario 'can edit the description' do
    fill_in "desc", with: 'I love Rails!'
    click_button 'Save'
    visit("/talk/#{@talk.id}")
    expect(page).to have_content('I love Rails!')
  end

  scenario 'can edit the resources' do
    fill_in 'resources_form', with: 'www.rails.com'
    click_button 'Save'
    visit("/talk/#{@talk.id}")
    expect(page).to have_content('www.rails.com')
  end
end

feature 'the current user is not the author of the talk', :type => :feature do

  before :each do
    @talk = Talk.create
    @talk.id = 1
    @talk.speaker_id = 1
    @talk.save
    # @current_user = User.new(session[{fullname: 'Morgan Wildermuth', email: "morgan.wildermuth@gmail.com", gravatar: "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", id: 633, cohort_id: 29}])
    login_as({fullname: 'Morgan Wildermuth', dbc_student_id: 633})
    visit("/talk/#{@talk.id}")
  end

  scenario 'does not show the description form' do
    expect(page).to have_no_selector('#desc_form')
  end

  scenario 'does not show the resource form' do
    page.should have_no_selector('#resources_form')
  end
end




