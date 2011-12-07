require 'spec_helper'

describe "Users" do
  describe "signup" do
    
    describe "failure" do
    
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          page.should have_selector("legend", :content => "Sign up")
          page.should have_selector("p.error_notification")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button "Sign up"
          page.should have_selector("div.alert-message.success",
                                        :content => "Welcome")
          page.should have_selector("img.gravatar")
        end.should change(User, :count).by(1)
      end
    end
  end
end
