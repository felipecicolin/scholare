# frozen_string_literal: true

module Pdf
  class AnswersController < ApplicationController
    def index
      test = current_user.tests.find(params[:test_id])
      pdf = Prawn::Document.new(page_size: "A4")

      test.students.each do |student|
        pdf.text "#{I18n.t("activerecord.attributes.student.name")}: #{student.name}", size: 14
        pdf.text "#{I18n.t("activerecord.attributes.student.identifier")}: #{student.identifier}", size: 14

        pdf.move_down 35

        test.questions.each do |question|
          pdf.draw_text question.number, at: [7, pdf.cursor], size: 13

          pdf.bounding_box([5, pdf.cursor], width: 30, height: 30) do
            pdf.draw_text "A", size: 12, style: :bold, at: [pdf.bounds.left + 30, pdf.cursor]
            pdf.draw_text "B", size: 12, style: :bold, at: [pdf.bounds.left + 50, pdf.cursor]
            pdf.draw_text "C", size: 12, style: :bold, at: [pdf.bounds.left + 70, pdf.cursor]
            pdf.draw_text "D", size: 12, style: :bold, at: [pdf.bounds.left + 90, pdf.cursor]
            pdf.draw_text "E", size: 12, style: :bold, at: [pdf.bounds.left + 110, pdf.cursor]

            pdf.move_up 4

            pdf.stroke_circle [pdf.bounds.left + 34, pdf.cursor], 9
            pdf.stroke_circle [pdf.bounds.left + 54, pdf.cursor], 9
            pdf.stroke_circle [pdf.bounds.left + 74, pdf.cursor], 9
            pdf.stroke_circle [pdf.bounds.left + 94, pdf.cursor], 9
            pdf.stroke_circle [pdf.bounds.left + 114, pdf.cursor], 9
          end
        end

        pdf.start_new_page
      end

      send_data(pdf.render,
                filename: "#{test.name}.pdf",
                type: "application/pdf",
                disposition: "inline")
    end
  end
end
