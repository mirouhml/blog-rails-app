require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET index' do
    before :each do
      get '/users'
    end

    it 'renders the index template' do
      expect(response).to render_template('users/index')
    end

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'loads the correct elements' do
      expect(response.body).to include('Users')
    end
  end

  describe 'GET show' do
    before :each do
      get '/users/index'
    end

    it 'renders the show template' do
      expect(response).to render_template('users/show')
    end

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'loads the correct elements' do
      expect(response.body).to include('User')
    end
  end
end
