require 'rails_helper'

RSpec.describe 'Site registration' do
  describe 'As a Visitor' do
    it "when I click the register button in the nav bar" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_link('Register')
        click_link 'Register'
      end

      expect(current_path).to eq('/register')
    end

    it "I can create a new account" do
      visit '/register'

        name = "Jimbo"
        address = '333 Jims House Way'
        city = "Denver"
        state = "CO"
        zip = "80237"
        email = "jim@jimsdawgs.com"
        password = "hunter2"

        fill_in :name, with: name
        fill_in :address, with: address
        fill_in :city, with: city
        fill_in :state, with: state
        fill_in :zip, with: zip
        fill_in :email, with: email
        fill_in :password, with: password
        fill_in :password_confirm, with: password

        click_button "Register"

        new_merchant = User.last

        expect(current_path).to eq('/profile')
        expect(new_merchant.name).to eq(name)
        expect(new_merchant.address).to eq(address)
        expect(new_merchant.city).to eq(city)
        expect(new_merchant.state).to eq(state)
        expect(new_merchant.zip).to eq(zip)
        expect(new_merchant.email).to eq(email)

        expect(page).to have_content("Successfully Registered")
    end
    it "When registering, if I do not fill everything out, I see a flash message" do
      visit '/register'

      name = "Jimbo"
      address = '333 Jims House Way'
      city = "Denver"
      state = "CO"
      zip = "80237"
      email = "jim@jimsdawgs.com"
      password = "hunter2"

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip
      fill_in :password, with: password
      fill_in :password_confirm, with: password

      click_button "Register"
      expect(page).to have_content("Email can't be blank")
    end
    it "When Registering I must use a unique email" do
      visit '/register'

        name = "Jimbo"
        address = '333 Jims House Way'
        city = "Denver"
        state = "CO"
        zip = "80237"
        email = "jim@jimsdawgs.com"
        password = "hunter2"

        fill_in :name, with: name
        fill_in :address, with: address
        fill_in :city, with: city
        fill_in :state, with: state
        fill_in :zip, with: zip
        fill_in :email, with: email
        fill_in :password, with: password
        fill_in :password_confirm, with: password

        click_button "Register"

        visit '/register'

        fill_in :name, with: name
        fill_in :address, with: address
        fill_in :city, with: city
        fill_in :state, with: state
        fill_in :zip, with: zip
        fill_in :email, with: email
        fill_in :password, with: password
        fill_in :password_confirm, with: password

        click_button "Register"

        expect(page).to have_content("Email is already in use.")
    end
  end
end
