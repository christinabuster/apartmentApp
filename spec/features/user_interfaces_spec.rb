require 'rails_helper'

RSpec.feature "UserInterfaces", type: :feature do

  # Story: As a user I can sign up with email address and password.
  describe "sign up with email address and password" do
    it "should go to sign up page" do
      visit 'users/sign_up'
      expect(page).to have_content("Sign up")
    end

    it "should sign up" do
      visit 'users/sign_up'
      expect(page).to have_content("Sign up")
      fill_in "user_email", with: "me@learn.com"
      fill_in "user_password", with: "notch8learn"
      fill_in "user_password_confirmation", with: "notch8learn"
      click_button "Sign up"
      expect(current_path).to eq('/')
      expect(page).to have_content("Rent My Space")
    end
  end
  # Login Test
  describe "login a user" do
    it "should go to the login page" do
      visit 'users/sign_in'
      expect(page).to have_content("Log in")
    end

    # Story: As a user I can log in and out.
    it "should log in a user" do
      create_user_andrew
      click_link "Logout"
      expect(page).to have_content("Login")
      fill_in "user_email", with: "me@learn.com"
      fill_in "user_password", with: "notch8learn"
      click_button "Login"
      expect(current_path).to eq('/')
      expect(page).to have_content("Rent My Space")
    end
    # Story: As a user I can only edit apartments that I have created.
    it "Should only permit user to edit content the have created" do
      create_user_me
      create_apt
      click_link "Logout"
      create_user_you
      expect(page).to have_no_content('Edit')
      expect(page).to have_no_content('Destroy')
    end

    # Story: As a user I can only remove apartments that I have created.
  end

  def create_user_me
    visit 'users/sign_up'
    expect(page).to have_content("Sign up")
    fill_in "user_email", with: "me@learn.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
  end

  def create_user_you
    visit 'users/sign_up'
    expect(page).to have_content("Sign up")
    fill_in "user_email", with: "you@learn.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
  end

  def create_apt
    click_link 'New Apartment'
    click_button 'Choose File'
    attach_file "File", "spec/asset_specs/photos/photo.jpg"
    fill_in "apartment[address]", with: "123 any street"
  end
end
