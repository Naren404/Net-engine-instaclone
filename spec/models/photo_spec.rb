# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:user) { create(:user) }

  context 'validation' do
    it 'should have a photo' do
      photo = user.photos.build(description: Faker::Lorem.sentence)
      expect(photo).to_not be_valid
    end

    it 'should be a valid photo' do
      file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')

      photo = user.photos.build(photo: file)
      expect(photo).to be_valid
    end
  end
end
