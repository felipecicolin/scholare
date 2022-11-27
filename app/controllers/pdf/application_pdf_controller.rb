# frozen_string_literal: true

module Pdf
  class ApplicationController < ActionController::Base
    layout false

    before_action :authenticate_user!
  end
end
