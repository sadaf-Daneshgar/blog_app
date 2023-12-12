require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes user name in the response body' do
      user
      get users_path
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes user name in the response body' do
      get user_path(user)
      expect(response.body).to include(user.name)
    end
  end
end
