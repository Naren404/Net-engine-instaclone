# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')

    @user = create(:user)
    @photo = @user.photos.build(photo: file)
  end

  context 'validation' do
    it 'should have a content' do
      comment = @photo.comments.build(user_id: @user.id)
      expect(comment).to_not be_valid
    end

    it 'should be a valid comment' do
      comment = @photo.comments.build(user_id: @user.id, content: Faker::Lorem.sentence)
      expect(comment).to be_valid
    end
  end
end
