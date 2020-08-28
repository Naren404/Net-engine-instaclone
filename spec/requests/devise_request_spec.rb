# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devise' do
  describe 'Registrations' do
    it 'should have an username' do
      expect{
        post '/users', params: {
            user: {
                email: Faker::Internet.email,
                password: Faker::Internet.password
            }
        }
      }.to_not change(User, :count)
    end

    it 'should create an user' do
      expect{
        post '/users', params: {
            user: {
                email: Faker::Internet.email,
                username: Faker::Internet.username,
                password: Faker::Internet.password
            }
        }
      }.to change(User, :count).by(1)
    end
  end

  describe 'Sessions' do
    it 'signs user in and out' do
      user = create(:user)
      user.confirm

      sign_in user
      get root_path
      expect(controller.current_user).to eq(user)

      sign_out user
      get root_path
      expect(controller.current_user).to be_nil
    end
  end
end
