# frozen_string_literal: true

module Pdf
  class ApplicationPdfController < ApplicationController
    respond_to :pdf

    layout "pdf"

    before_action :authenticate_user!
  end
end
