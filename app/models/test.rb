# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :school_class

  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :test_date, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true
end
