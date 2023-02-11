require 'rails_helper'

VALID_PASSWORD = 'Password'.freeze
INVALID_PASSWORD = 'p'.freeze

RSpec.feature "Registrations", type: :feature do
  before do
    visit new_user_registration_path
    fill_in 'First Name', with: 'Name'
    fill_in 'Last Name', with: 'Name'
    select '1950', from: 'user_birth_date_1i'
    select 'January', from: 'user_birth_date_2i'
    select '1', from: 'user_birth_date_3i'
    fill_in 'Email', with: Faker::Internet.unique.email
    fill_in 'Password', with: VALID_PASSWORD
    fill_in 'Password confirmation', with: VALID_PASSWORD
  end
  context 'when all fields are valid' do
    it 'creates a user' do
      click_on 'Sign up'
      expect(page).to have_content('Sign Out')
    end
  end
  context 'when first name is blank' do
    it 'returns an error' do
      fill_in 'First Name', with: ''
      click_on 'Sign up'
      expect(page).to have_content('First name can\'t be blank')
    end
  end

  context 'when last name is blank' do
    it 'returns an error' do
      fill_in 'Last Name', with: ''
      click_on 'Sign up'
      expect(page).to have_content('Last name can\'t be blank')
    end
  end

  context 'when age would be less than 13' do
    it 'returns an error' do
      time = Time.now - 12.years - 364.days
      select time.year.to_s, from: 'user_birth_date_1i'
      select time.strftime('%B'), from: 'user_birth_date_2i'
      select time.day.to_s, from: 'user_birth_date_3i'
      click_on 'Sign up'
      expect(page).to have_content('You must be at least 13 years old to sign up')
    end
  end

  context 'when email is blank' do
    it 'returns an error' do
      fill_in 'Email', with: ''
      click_on 'Sign up'
      expect(page).to have_content('Email can\'t be blank')
    end
  end

  context 'when password is blank' do
    it 'returns an error' do
      fill_in 'Password', with: ''
      click_on 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
    end
  end

  context 'when password is too short' do
    it 'returns an error' do
      fill_in 'Password', with: INVALID_PASSWORD
      click_on 'Sign up'
      expect(page).to have_content('Password is too short')
    end
  end
end
