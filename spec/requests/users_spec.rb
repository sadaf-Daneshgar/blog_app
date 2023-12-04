require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Hello! this is the user index')
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('Hello! this is the user show')
    end
  end
end
