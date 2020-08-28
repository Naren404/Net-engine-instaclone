# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  describe 'GET index' do
    it 'should return a 200 response' do
      get photos_path
      expect(response).to have_http_status(:ok)
    end
  end
end
