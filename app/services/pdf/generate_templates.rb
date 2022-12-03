# frozen_string_literal: true

module Pdf
  class GenerateTemplates < ApplicationService
    def initialize(test)
      @pdf = Prawn::Document.new(page_size: "A4")
      @test = test
    end

    def call
      generate_templates
      @pdf
    end

    private

    def generate_templates
      @test.students.each do |student|
        draw_test_and_student_informations(student)
        @pdf.move_down 45
        draw_questions
        draw_feedback_corners
        @pdf.start_new_page
      end
    end

    def draw_test_and_student_informations(student)
      @pdf.text "#{I18n.t('activerecord.attributes.test.name')}: #{@test.name}", size: 14
      @pdf.text "#{I18n.t('activerecord.attributes.student.school_class')}: #{student.school_class.name}", size: 14
      @pdf.text "#{I18n.t('activerecord.attributes.student.name')}: #{student.name}", size: 14
      @pdf.text "#{I18n.t('activerecord.attributes.student.identifier')}: #{student.identifier}", size: 14
    end

    def draw_questions
      @test.questions.each do |question|
        @pdf.draw_text question.number, at: [10, @pdf.cursor], size: 13

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
        base_spacing += 25
      end
    end

    def draw_questions_circles
      base_spacing = 34
      @pdf.line_width = 1.6

      5.times do
        @pdf.stroke_circle [@pdf.bounds.left + base_spacing, @pdf.cursor], 9
        base_spacing += 25
      end

      @pdf.line_width = 0
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
      @pdf.stroke_line [0, 650], [0, 693]
      @pdf.stroke_line [0, 690], [45, 690]
    end

    def draw_top_right_corners
      @pdf.stroke_line [111, 690], [163, 690]
      @pdf.stroke_line [160, 690], [160, 650]
    end

    def draw_bottom_right_corners
      @pdf.stroke_line [160, @pdf.cursor + 10], [160, @pdf.cursor + 55]
      @pdf.stroke_line [110, @pdf.cursor + 10], [163, @pdf.cursor + 10]
    end

    def draw_bottom_left_corners
      @pdf.stroke_line [0, @pdf.cursor + 10], [0, @pdf.cursor + 55]
      @pdf.stroke_line [-3, @pdf.cursor + 10], [45, @pdf.cursor + 10]
    end
  end
end
