# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :school_class
  belongs_to :user

  has_many :tests, through: :school_class
  has_many :test_grades, dependent: :destroy

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  default_scope { order(:name) }
end
