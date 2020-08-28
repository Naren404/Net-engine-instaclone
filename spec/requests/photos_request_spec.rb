# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  let(:file) {fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')}

  before :each do
    @user_with_photo = create(:user)
    @user_with_photo.confirm

    @photo = @user_with_photo.photos.create(photo: file)
  end

  describe 'GET index' do
    it 'should return a 200 response' do
      get photos_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    it 'should have a valid photo id' do
      photo_id = Photo.last.id + 1

      get photo_path(photo_id)
      expect(response).to have_http_status(:found)
    end

    it 'should return a 200 response' do
      get photo_path(@photo)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    it 'should return a 302 response' do
      get new_photo_path
      expect(response).to have_http_status(:found)
    end

    it 'should return a 200 response' do
      sign_in @user_with_photo

      get new_photo_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    before :each do
      sign_in @user_with_photo
    end

    it 'should have a photo' do
      expect{
        post '/photos', params: {photo: {description: Faker::Lorem.sentence}}
      }.to_not change(ActiveStorage::Attachment, :count)
    end

    it 'should store a photo' do
      expect{
        post '/photos', params: {photo: {photo: file}}
      }.to change(ActiveStorage::Attachment, :count).by(1)
    end
  end

  describe 'DELETE destroy' do
    it 'should prevent user to delete photos from other users' do
      user_without_photo = create(:user)
      user_without_photo.confirm

      sign_in user_without_photo

      expect{delete photo_path(@photo)}.to_not change(Photo, :count)
    end

    it 'should allow user to delete their own photos' do
      sign_in @user_with_photo

      expect{delete photo_path(@photo)}.to change(Photo, :count).by(-1)
    end
  end
end
