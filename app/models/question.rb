# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  validates :title, :body, :value, presence: true
end
