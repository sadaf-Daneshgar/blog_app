require 'rails_helper'

RSpec.describe 'Users index', type: :feature do
  let(:users) { FactoryBot.create_list(:user, 5) }

  before do
    users
    visit users_path
  end

  describe 'Users index page' do
    it 'displays correct number of users' do
      expect(page).to have_css('div.user_info', count: 5)
    end

    it 'displays all users photos' do
      users.each do |_user|
        expect(page).to have_css("img[alt='User Photo']")
      end
    end

    it 'displays all users names' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'displays all users posts count' do
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end
end
