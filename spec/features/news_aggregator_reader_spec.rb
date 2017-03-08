require 'spec_helper'
require 'pry'

feature 'User reviews articles', %(
  As a slacker
  I want to be able to visit a page that shows me all the submitted articles
  So that I can slack off

  [X] When I visit /articles I should be able to see all the articles that have been submitted.
  [X] Each article should show the description, title, and URL.
  [] If I click on the URL it should take me to the relevant page inside of a new tab.
) do

  scenario "when I visit /articles I should see all submitted articles" do
    visit 'articles/new'

    fill_in 'Article Title', with: 'How to Beat the Robots'
    fill_in 'Article URL', with: 'https://www.nytimes.com/2017/03/07/upshot/how-to-beat-the-robots.html?rref=collection%2Fsectioncollection%2Ftechnology&action=click&contentCollection=technology&region=stream&module=stream_unit&version=latest&contentPlacement=6&pgtype=sectionfront'
    fill_in 'Article Description', with: 'This is an article about how to survive in a world of automation'

    click_button "Submit"
    visit 'articles/new'

    fill_in 'Article Title', with: 'Solar power growth leaps by 50% worldwide thanks to US and China'
    fill_in 'Article URL', with: 'https://www.theguardian.com/environment/2017/mar/07/solar-power-growth-worldwide-us-china-uk-europe'
    fill_in 'Article Description', with: 'This is an article about solar power growth'

    click_button "Submit"
    visit '/articles'

    expect(page).to have_content('How to Beat the Robots')
    expect(page).to have_content('Solar power growth leaps by 50% worldwide thanks to US and China')
  end

  scenario "each article should display the description, title, and url" do
    visit '/articles'

    expect(page).to have_content('How to Beat the Robots')
    expect(page).to have_content('This is an article about how to survive in a world of automation')
  end

  scenario "clicking the URL should open a new tab with the article", js: true do
    visit '/articles'

    new_tab = window_opened_by do
      click_link('This is an article about how to survive in a world of automation')
    end

    within_window new_tab do
      expect(page).to have_content('How to Beat the Robots')
    end
  end
end
