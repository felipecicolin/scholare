# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :school_class

  has_many :tests, dependent: :nullify

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true
end
