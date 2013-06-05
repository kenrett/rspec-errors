require 'spec_helper'

describe 'Admin', :js => true  do

  let(:user) { User.create(email: "ex@ex.com", password: "whocares") }

  context "signup" do
    it "logs user in and redirects to admin home upon successful singup" do
      visit new_user_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Signup'
      page.should have_content "Welcome"
    end

    it "displays errors on unsuccessful signup" do 
      visit new_user_path
      fill_in 'user_email', with: "ken"
      click_button 'Signup'
      page.should have_content "Signup"
    end
  end

  context "login" do

    it "redirects to admin_root after successful login" do
      visit new_user_path #need to do this so that user exists first
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Signup'

      visit new_session_path

      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button "Login"
      page.should have_content "Welcome"
    end

    it "displays errors on unsuccessful login" do
      visit new_user_path
      fill_in 'email', with: "ken"
      click_button 'Signup'
      page.should have_content "Signup"
    end
  end

  context "on admin homepage" do
    it "can see a list of recent posts"
    it "can edit a post by clicking the edit link next to a post"
    it "can delete a post by clicking the delete link next to a post"
    it "can create a new post and view it" do
      visit new_admin_post_path

      expect {
        fill_in 'post_title',   with: "Hello world!"
        fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
        page.check('post_is_published')
        click_button "Save"
        }.to change(Post, :count).by(1)

        page.should have_content "Published: true"
        page.should have_content "Post was successfully saved."
      end
    end
  end


  context "editing post" do
    it "can mark an existing post as unpublished" do
      pending # remove this line when you're working on implementing this test

      page.should have_content "Published: false" 
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title"
    it "can see an edit link that takes you to the edit post path"
    it "can go to the admin homepage by clicking the Admin welcome page link"
  end
end
