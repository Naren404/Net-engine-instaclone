# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all

  has_one_attached :photo

  validates :photo, presence: true
end
