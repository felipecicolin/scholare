# frozen_string_literal: true

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def magic_link(user, login_link)
    @user = user
    @login_link = login_link
    mail to: @user.email, subject: t("user_mailer.sign_in_to_our_app")
  end
end
