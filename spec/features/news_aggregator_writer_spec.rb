require 'spec_helper'
require 'pry'

feature 'User submits an article', %(
  As a slacker
  I want to be able to submit an incredibly interesting article
  So that other slackers may benefit

  Acceptance Criteria:
  [X] When I visit /articles/new it has a form to submit a new article
  [X] The form accepts an article title, URL, and description
  [X] When I successfully post an article, it should be saved to a CSV file
) do

  scenario "user visits /articles/new and sees a form" do
    visit '/articles/new'

    expect(page).to have_field('article_title')
    #probably should also test for form
  end

  scenario "the form accepts an article title, URL, and description" do
    visit 'articles/new'

    fill_in 'Article Title:', with: 'How to Beat the Robots'
    fill_in 'Article URL:', with: 'https://www.nytimes.com/2017/03/07/upshot/how-to-beat-the-robots.html?rref=collection%2Fsectioncollection%2Ftechnology&action=click&contentCollection=technology&region=stream&module=stream_unit&version=latest&contentPlacement=6&pgtype=sectionfront'
    fill_in 'Article Description:', with: 'This is an article about how to survive in a world of automation'
    #maybe test for actual format of URL
  end

  scenario "when I successfully post an article it should be saved to a CSV file" do
    visit 'articles/new'

    fill_in 'Article Title', with: 'How to Beat the Robots'
    fill_in 'Article URL', with: 'https://www.nytimes.com/2017/03/07/upshot/how-to-beat-the-robots.html?rref=collection%2Fsectioncollection%2Ftechnology&action=click&contentCollection=technology&region=stream&module=stream_unit&version=latest&contentPlacement=6&pgtype=sectionfront'
    fill_in 'Article Description', with: 'This is an article about how to survive in a world of automation'

    click_button "Submit"
    visit '/articles'

    expect(page).to have_content('How to Beat the Robots')
  end
end
