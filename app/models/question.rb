# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test
  belongs_to :user

  has_many :alternatives, dependent: :destroy

  validates :body, :value, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :number, uniqueness: { scope: :test_id }

  validate :at_least_one_correct_alternative_is_required
  validate :only_one_correct_alternative_is_permitted

  before_create :set_number
  after_destroy :normalize_test_questions_numbers

  accepts_nested_attributes_for :alternatives

  default_scope { order(:number) }

  private

  def set_number
    self.number = test.questions.count + 1
  end

  def normalize_test_questions_numbers
    test.questions.where("number > ?", number).find_each do |question|
      question.update(number: question.number - 1)
      question.save
    end
  end

  def at_least_one_correct_alternative_is_required
    return if alternatives.any?(&:correct)

    errors.add(:base, I18n.t("errors.messages.at_least_one_correct_alternative_is_required"))
  end

  def only_one_correct_alternative_is_permitted
    return if alternatives.count(&:correct) <= 1

    errors.add(:base, I18n.t("errors.messages.only_one_correct_alternative_is_permitted"))
  end
end
