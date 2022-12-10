# frozen_string_literal: true

class SchoolClass < ApplicationRecord
  belongs_to :user

  has_many :students, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }

  default_scope { order(:name) }
end
