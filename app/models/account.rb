# frozen_string_literal: true

class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP

  def self.authenticate(email, password)
    account = Account.find_for_authentication(email: email)
    account&.valid_password?(password) ? account : nil
  end
end
