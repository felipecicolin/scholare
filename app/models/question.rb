# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :alternatives, dependent: :destroy

  validates :body, :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
