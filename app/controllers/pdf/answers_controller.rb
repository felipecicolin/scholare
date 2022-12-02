# frozen_string_literal: true

module Pdf
  class AnswersController < ApplicationController
    def index # rubocop:disable Metrics/AbcSize
      test = current_user.tests.find(params[:test_id])
      pdf = Prawn::Document.new(page_size: "A4")

      test.students.each do |student|
        pdf.text "#{I18n.t('activerecord.attributes.student.name')}: #{student.name}", size: 14
        pdf.text "#{I18n.t('activerecord.attributes.student.identifier')}: #{student.identifier}", size: 14

        pdf.move_down 35

        render_all_the_questions(pdf, test)
        render_all_the_corners(pdf, test)

        pdf.start_new_page
      end

      send_data(pdf.render,
                filename: "#{test.name}.pdf",
                type: "application/pdf",
                disposition: "inline")
    end

    def render_all_the_questions(pdf, test)
      test.questions.each do |question|
        pdf.draw_text question.number, at: [15, pdf.cursor], size: 13

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
    end

    def render_all_the_corners(pdf, test)
      pdf.line_width = 5

      pdf.bounding_box([4.4, 726], width: 40, height: 0) { pdf.stroke_bounds }

      pdf.bounding_box([7, 726], width: 0, height: 40) { pdf.stroke_bounds }

      pdf.bounding_box([102.5, 726], width: 40, height: 0) { pdf.stroke_bounds }

      pdf.bounding_box([140, 726], width: 0, height: 40) { pdf.stroke_bounds }

      pdf.bounding_box([140, test.questions.count * 121], width: 0, height: 40) { pdf.stroke_bounds }

      pdf.bounding_box([102.5, test.questions.count * 113], width: 40, height: 0) { pdf.stroke_bounds }

      pdf.bounding_box([7, test.questions.count * 121], width: 0, height: 40) { pdf.stroke_bounds }

      pdf.bounding_box([4.6, test.questions.count * 113], width: 40, height: 0) { pdf.stroke_bounds }

      pdf.line_width = 0
    end
  end
end
