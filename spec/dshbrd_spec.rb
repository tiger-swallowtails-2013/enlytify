require 'spec_helper'
require 'sinatra'

feature 'user is able to view next/prev day\'s lightning talks', :type => :feature do
  scenario 'shows current day\'s lightning talks' do
    @date = Time.now.to_date
    visit "/dashboard/#{@date}"
    expect (page).to have_content("#{@date}")
  end  

  scenario 'if not logged in doesnt show talks on dashboard', :js => true do
    @date = Time.now.to_date
    visit "/dashboard/#{@date}"
    expect page.has_content?("not") 
  end

  scenario 'when clicking on next page, shows next day\'s talks' do
  end

  scenario 'when clicking on prev page, shows prev day\'s talks' do
  end
end


