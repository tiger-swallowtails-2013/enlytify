require 'spec_helper'

feature 'the current user is the author of the talk', :type => :feature do

  before :each do
    @current_user = User.new({'name' => 'Morgan Wildermuth', 'email' => "morgan.wildermuth@gmail.com", 'gravatar' => "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", 'id' => 633})
    visit('/talk')
  end

  scenario 'shows the description form' do
    page.has_selector?('input#desc_form', :visible => true)
  end

  scenario 'shows the resource form' do
    page.has_selector?('input#resource_form', visible: true)
  end

  scenario 'can edit the description' do
    fill_in "#{name}['desc']", with: 'I love Rails!'
    click_button 'Save Description'
    visit('/talk')
    expect(page).to have_content('I love Rails!')
  end

  scenario 'can edit the resources' do
    page.fill_in 'resources_form', with: 'www.rails.com'
    click_button 'Save Resources'
    visit('/talk')
    expect(page).to have_content('www.rails.com')
  end
end

feature 'the current user is not the author of the talk', :type => :feature do

  before :each do
    @current_user = User.new({'name' => 'Morgan Wildermuth', 'email' => "morgan.wildermuth@gmail.com", 'gravatar' => "https://secure.gravatar.com/avatar/c08bab8ea8340a2598b06a54beade3cb.png?d=mm&r=PG&s=250", 'id' => 633})
    visit('/talk')
  end

  scenario 'does not show the description form' do
    page.should have_selector('#description', visible: false)
  end

  scenario 'does not show the resource form' do
    page.should have_selector('#resource_form', visible: false)
  end
end




