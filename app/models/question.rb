# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :alternatives, dependent: :destroy

  validates :body, :value, presence: true

  validates :value, numericality: { greater_than: 0 }

  validates :essay_question, inclusion: { in: [true, false] }

  validates :alternatives, presence: true, unless: :essay_question?
  validates :alternatives, absence: true, if: :essay_question?
end
