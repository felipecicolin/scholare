# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user
  belongs_to :student

  has_many :questions, dependent: :destroy
end
