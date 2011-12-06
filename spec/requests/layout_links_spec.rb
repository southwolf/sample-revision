require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.body.should have_selector("title", :text => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.body.should have_selector('title', :text => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.body.should have_selector('title', :text => "About")
  end
  
  it "should have a Help page at '/help'" do
    get '/help'
    response.body.should have_selector('title', :text => "Help")
  end

  it "should have a Signup page at '/signup'" do
    get '/signup'
    response.body.should have_selector('title', :text => "Sign up")
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Sign up now!"
    page.should have_selector('title', :text => "Sign up")
    click_link "About"
    page.should have_selector('title', :text => "About")
    click_link "Help"
    page.should have_selector('title', :text => "Help")
    click_link "Contact"
    page.should have_selector('title', :text => "Contact")
    click_link "Home"
    page.should have_selector('title', :text => "Home")
  end
end
