# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :school_class
  belongs_to :user

  has_many :tests, dependent: :nullify

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  # ransacker :school_class_id do
  #   Arel.sql("\"students\".\"school_class_id\"::varchar")
  # end
end
