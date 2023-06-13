# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :validatable

  has_secure_token :auth_token, length: 36

  has_many :tests, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :school_classes, dependent: :destroy
  has_many :students, dependent: :destroy
end
