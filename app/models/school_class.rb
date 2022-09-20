# frozen_string_literal: true

class SchoolClass < ApplicationRecord
  belongs_to :user

  has_many :students, dependent: :destroy

  validates :name, presence: true
end
