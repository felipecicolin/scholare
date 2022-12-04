# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :user
  belongs_to :school_class

  has_many :questions, dependent: :destroy
  has_many :students, through: :school_class
  has_many :test_grades, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :test_date, presence: true
  validate :ensure_test_date_is_in_the_future

  private

  def ensure_test_date_is_in_the_future
    return if test_date.blank?

    errors.add(:test_date, I18n.t("errors.messages.must_be_in_the_future")) if test_date <= Time.zone.today
  end
end
