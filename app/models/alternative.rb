# frozen_string_literal: true

class Alternative < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validates :correct, inclusion: { in: [true, false] }
  validates :option, inclusion: { in: %w[A B C D E] }
end
