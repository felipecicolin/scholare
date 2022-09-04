# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false },
            presence: true

  def send_magic_link
    generate_login_token

    UserMailer.magic_link(self, login_link).deliver_now
  end

  # generates login token to authorize user
  def generate_login_token
    # create a login_token and set it up to expire in 60 minutes
    payload = {
      email:,
      exp: 5.minutes.from_now.to_i
    }
    # set login_token to validate last sent login token
    self.login_token = generate_token(payload)
    save!
  end

  # returns the magic link which is to be included in the email
  def login_link
    Rails.application.routes.url_helpers.sessions_create_url(login_token:, host: ENV.fetch("HOST"))
  end

  private

  def generate_token(token_payload)
    JsonWebToken.encode(token_payload)
  end
end
