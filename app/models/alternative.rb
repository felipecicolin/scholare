# frozen_string_literal: true

class Alternative < ApplicationRecord
  belongs_to :question

  validates :option, :body, presence: true
  validates :option, inclusion: { in: %w[A B C D E] }

  validates :correct, inclusion: { in: [true, false] }
end
