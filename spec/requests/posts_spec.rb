require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET index' do
    before :each do
      get '/users/1/posts'
    end

    it 'renders the index template' do
      expect(response).to render_template('posts/index')
    end

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    before :each do
      get '/users/index/posts/index'
    end

    it 'renders the show template' do
      expect(response).to render_template('posts/show')
    end

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
