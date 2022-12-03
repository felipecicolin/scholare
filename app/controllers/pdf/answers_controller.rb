# frozen_string_literal: true

module Pdf
  class AnswersController < ApplicationController
    before_action :set_test, only: :index

    def index
      @pdf = Prawn::Document.new(page_size: "A4")
      draw_feedbacks
      send_data(@pdf.render, filename: "#{@test.name}.pdf", type: "application/pdf", disposition: "inline")
    end

    private

    def draw_feedbacks
      @test.students.each do |student|
        draw_student_name_and_identifier(student)
        @pdf.move_down 35
        draw_questions
        draw_feedback_corners
        @pdf.start_new_page
      end
    end

    def draw_student_name_and_identifier(student)
      @pdf.text "#{I18n.t('activerecord.attributes.student.name')}: #{student.name}", size: 14
      @pdf.text "#{I18n.t('activerecord.attributes.student.identifier')}: #{student.identifier}", size: 14
    end

    def draw_questions
      @test.questions.each do |question|
        @pdf.draw_text question.number, at: [15, @pdf.cursor], size: 13

        @pdf.bounding_box([5, @pdf.cursor], width: 30, height: 30) do
          draw_questions_letters
          @pdf.move_up 4
          draw_questions_circles
        end
      end
    end

    def draw_questions_letters
      base_spacing = 30

      %w[A B C D E].each do |letter|
        @pdf.draw_text letter, size: 12, style: :bold, at: [@pdf.bounds.left + base_spacing, @pdf.cursor]
        base_spacing += 20
      end
    end

    def draw_questions_circles
      base_spacing = 34

      5.times do
        @pdf.stroke_circle [@pdf.bounds.left + base_spacing, @pdf.cursor], 9
        base_spacing += 20
      end
    end

    def draw_feedback_corners
      @pdf.line_width = 6

      draw_top_left_corners
      draw_top_right_corners
      draw_bottom_left_corners
      draw_bottom_right_corners

      @pdf.line_width = 0
    end

    def draw_top_left_corners
      @pdf.stroke_line [0, 700], [0, 730]
      @pdf.stroke_line [0, 730], [30, 730]
    end

    def draw_top_right_corners
      @pdf.stroke_line [117, 730], [150, 730]
      @pdf.stroke_line [150, 730], [150, 700]
    end

    def draw_bottom_right_corners
      @pdf.stroke_line [150, @pdf.cursor], [150, @pdf.cursor + 30]
      @pdf.stroke_line [117, @pdf.cursor], [150, @pdf.cursor]
    end

    def draw_bottom_left_corners
      @pdf.stroke_line [0, @pdf.cursor], [0, @pdf.cursor + 30]
      @pdf.stroke_line [0, @pdf.cursor], [30, @pdf.cursor]
    end

    def set_test
      @test = current_user.tests.find(params[:test_id])
    end
  end
end
