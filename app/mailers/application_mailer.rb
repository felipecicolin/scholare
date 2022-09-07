# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "support@scholare.com"
  layout "mailer"
end
