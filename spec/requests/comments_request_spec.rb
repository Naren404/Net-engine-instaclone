# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before :each do
    @user_with_comment = create(:user)
    @user_with_comment.confirm

    @user_without_comment = create(:user)
    @user_without_comment.confirm

    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    @photo = @user_with_comment.photos.create(photo: file)
    @content = Faker::Lorem.sentence
    @comment = @photo.comments.create(user_id: @user_with_comment.id, content: @content)
  end

  describe 'POST create' do
    before :each do
      sign_in @user_with_comment
    end

    it 'should have a content' do
      expect{
        post '/comments', params: {photo_id: @photo.id}
      }.to_not change(Comment, :count)
    end

    it 'should create a comment' do
      expect{
        post '/comments', params: {photo_id: @photo.id, content: Faker::Lorem.sentence}
      }.to change(Comment, :count).by(1)
    end
  end

  describe 'GET edit' do
    it 'should prevent user to edit comment from other users' do
      sign_in @user_without_comment

      get edit_comment_path(@comment)
      expect(response).to have_http_status(:found)
    end

    it 'should allow user to edit their own comment' do
      sign_in @user_with_comment

      get edit_comment_path(@comment)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT update' do
    it 'should prevent user to update comment from other users' do
      sign_in @user_without_comment

      put '/comments/' + @comment.id.to_s, params: {content: Faker::Lorem.sentence}

      @comment.reload

      expect(@comment.content).to eq(@content)
    end

    it 'should allow user to update their own comment' do
      sign_in @user_with_comment

      new_content = Faker::Lorem.sentence
      put '/comments/' + @comment.id.to_s, params: {content: new_content}

      @comment.reload

      expect(@comment.content).to eq(new_content)
    end
  end

  describe 'DELETE destroy' do
    it 'should prevent user to delete comment from other users' do
      sign_in @user_without_comment

      expect{delete comment_path(@comment)}.to_not change(Comment, :count)
    end

    it 'should allow user to delete their own comment' do
      sign_in @user_with_comment

      expect{delete comment_path(@comment)}.to change(Comment, :count).by(-1)
    end
  end
end
