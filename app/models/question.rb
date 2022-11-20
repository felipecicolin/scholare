# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test
  belongs_to :user

  has_many :alternatives, dependent: :destroy

  validates :body, :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
