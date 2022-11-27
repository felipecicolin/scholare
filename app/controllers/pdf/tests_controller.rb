# frozen_string_literal: true

module Pdf
  class TestsController < ApplicationPdfController
    def show
      @test = current_user.tests.find(params[:test_id])

      render pdf: "tests",
             formats: [:html],
             page_size: "A4",
             encoding: "UTF-8",
             margin: { left: 20, right: 20 },
             zoom: 1,
             dpi: 300
    end
  end
end
