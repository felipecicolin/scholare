# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test
  belongs_to :user

  has_many :alternatives, dependent: :destroy

  accepts_nested_attributes_for :alternatives

  validates :body, :value, presence: true
  validates :value, numericality: { greater_than: 0 }

  validate :at_least_one_correct_alternative_is_required
  validate :only_one_correct_alternative_is_permitted

  private

  def at_least_one_correct_alternative_is_required
    return if alternatives.any?(&:correct)

    errors.add(:base, I18n.t("errors.messages.at_least_one_correct_alternative_is_required"))
  end

  def only_one_correct_alternative_is_permitted
    return if alternatives.count(&:correct) <= 1

    errors.add(:base, I18n.t("errors.messages.only_one_correct_alternative_is_permitted"))
  end
end
