# frozen_string_literal: true

class TestGrade < ApplicationRecord
  belongs_to :test
  belongs_to :student

  validates :grade, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
