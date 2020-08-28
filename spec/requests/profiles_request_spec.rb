# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  describe 'GET index' do
    it 'without username param should return a 200 response' do
      get profiles_path
      expect(response).to have_http_status(:ok)
    end

    it 'with username param should return correct user' do
      searched_username = Faker::Internet.username
      non_searched_username = Faker::Internet.username

      create(:user, username: searched_username)
      create(:user, username: non_searched_username)

      get profiles_path, params: {username: searched_username}

      expect(response.body).to include(searched_username)
      expect(response.body).to_not include(non_searched_username)
    end
  end

  describe 'GET show' do
    it 'should have a valid profile id' do
      get profile_path(Faker::Internet.username)
      expect(response).to have_http_status(:found)
    end
  end
end
