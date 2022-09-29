# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :validatable

  has_many :tests, dependent: :destroy
  has_many :school_classes, dependent: :destroy
  has_many :students, dependent: :destroy
end
