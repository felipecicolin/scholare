# frozen_string_literal: true

module Pdf
  class ApplicationPdfController < ActionController::Base
    layout false

    before_action :authenticate_user!
  end
end
