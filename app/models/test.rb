# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy

  validates :subject, presence: true
end
