# frozen_string_literal: true

module Pdf
  class TestsController < ApplicationController
    def index
      test = current_user.tests.find(params[:test_id])

      pdf = Pdf::GenerateTest.call(test)

      send_data(pdf.render, filename: "#{test.name}.pdf", type: "application/pdf", disposition: "inline")
    end
  end
end
