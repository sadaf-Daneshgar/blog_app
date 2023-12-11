require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:posts) { FactoryBot.create_list(:post, 5, author: user) }

  before do
    posts
    visit user_path(user)
  end

  describe 'User show page' do
    it 'displays user photo' do
      expect(page).to have_css("img[alt='User Photo']")
    end

    it 'displays user name' do
      expect(page).to have_content(user.name)
    end

    it 'displays user posts count' do
      expect(page).to have_content(user.posts_counter)
    end

    it 'displays user posts' do
      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'displays user posts likes count' do
      posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it 'displays user posts comments count' do
      posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end
  end
end
