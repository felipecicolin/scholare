# frozen_string_literal: true

module Pdf
  class TestsController < ApplicationController
    before_action :set_test, only: :index

    def index
      @pdf = Prawn::Document.new(page_size: "A4", title: "Test #{@test.id}")
      draw_test
      send_data(@pdf.render, filename: "#{@test.name}.pdf", type: "application/pdf", disposition: "inline")
    end

    private

    def draw_test
      draw_test_name_and_date
      @pdf.move_down 20
      draw_questions
    end

    def draw_test_name_and_date
      @pdf.text @test.name, align: :center, size: 22, style: :bold
      @pdf.text @test.test_date.strftime("%d/%m/%Y"), align: :center, size: 13
    end

    def draw_questions
      @test.questions.each do |question|
        draw_question_number(question)
        @pdf.move_down 15
        draw_alternatives(question)
        @pdf.move_down 15
      end
    end

    def draw_question_number(question)
      @pdf.text "<b>#{question.number}.</b> #{question.body}", inline_format: true, size: 12
    end

    def draw_alternatives(question)
      question.alternatives.each do |alternative|
        @pdf.text "<b>#{alternative.option}.</b> #{alternative.body}", inline_format: true
      end
    end

    def set_test
      @test = current_user.tests.find(params[:test_id])
    end
  end
end
