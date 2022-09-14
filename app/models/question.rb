# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  validates :body, :value, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :essay_question, inclusion: { in: [true, false] }
end
