# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :school_class

  has_many :questions, dependent: :destroy
end
