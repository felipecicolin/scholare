# frozen_string_literal: true

module Pdf
  class TestsController < ApplicationController
    before_action :set_test
    before_action :handle_questions_missing, only: :index

    def index
      pdf = Pdf::GenerateTest.call(@test)

      send_data(pdf.render, filename: "#{@test.name}.pdf",
                            type: "application/pdf",
                            disposition: "inline")
    end

    private

    def handle_questions_missing
      redirect_to tests_path, alert: t("pdfs.alert.no_questions") unless @test.questions.any?
    end

    def set_test
      @test = current_user.tests.find(params[:test_id])
    end
  end
end
