# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it 'should have an username' do
      user = build(:user, username: nil)
      expect(user).to_not be_valid
    end

    it 'should have an email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'should have a password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it 'should be a valid user' do
      user = create(:user)
      expect(user).to be_valid
    end

    it 'should have an unique username' do
      username = Faker::Internet.username
      create(:user, username: username)

      user_same_username = build(:user, username: username)
      expect(user_same_username).to_not be_valid
    end
  end
end
