# frozen_string_literal: true

module Pdf
  class TemplatesController < ApplicationController
    def index
      test = current_user.tests.find(params[:test_id])

      pdf = Pdf::GenerateTemplates.call(test)

      send_data(pdf.render, filename: "Template - #{test.name}.pdf",
                            type: "application/pdf",
                            disposition: "inline")
    end
  end
end
