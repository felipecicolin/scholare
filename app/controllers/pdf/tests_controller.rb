# frozen_string_literal: true

module Pdf
  class TestsController < ApplicationController
    def index # rubocop:disable Metrics/AbcSize
      test = current_user.tests.find(params[:test_id])
      pdf = Prawn::Document.new(page_size: "A4")

      pdf.text test.name, align: :center, size: 26, style: :bold
      pdf.text test.test_date.strftime("%d/%m/%Y"), align: :center, size: 10

      pdf.move_down 20

      test.questions.each do |question|
        pdf.text question.body

        pdf.move_down 15

        question.alternatives.each do |alternative|
          pdf.text "<b>#{alternative.option}.</b> #{alternative.body}", inline_format: true
        end

        pdf.move_down 15
      end

      send_data(pdf.render,
                filename: "#{test.name}.pdf",
                type: "application/pdf",
                disposition: "inline")
    end
  end
end
