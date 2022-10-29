# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :school_class

  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :test_date, presence: true
  validates_associated :questions

  accepts_nested_attributes_for :questions
end
