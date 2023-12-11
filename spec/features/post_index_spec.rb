require 'rails_helper'

RSpec.describe 'PostIndex', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:comments) { FactoryBot.create_list(:comment, 3, post:, author: user, created_at: 4.days.ago) }
  let(:recent_comments) { FactoryBot.create_list(:comment, 5, post:, author: user) }

  before do
    post
    comments
    visit user_posts_path(user)
  end

  describe 'User section in user posts index' do
    it 'shows user name' do
      expect(page).to have_content(user.name)
    end

    it 'shows user photo' do
      expect(page).to have_css("img[alt='User Photo']")
    end
  end

  describe 'Posts section in user posts index' do
    it 'Shows post heading' do
      expect(page).to have_content('Post📝')
    end

    it 'Shows post content' do
      expect(page).to have_content(post.text)
    end
  end

  describe 'Comments section in user posts index' do
    it 'Shows comment heading' do
      expect(page).to have_content('Comments:💬')
    end

    it 'Shows comments count' do
      expect(page).to have_content(post.comments_counter)
    end

    it 'Shows five most recent comments' do
      recent_comments.reverse.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'Shows comment content' do
      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
