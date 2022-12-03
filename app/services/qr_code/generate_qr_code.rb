# frozen_string_literal: true

module QrCode
  class GenerateQrCode < ApplicationService
    def initialize(test, student)
      @test = test
      @student = student
      @questions = @test.questions
    end

    def call
      create_correct_alternatives_list
      create_questions_values_list
      generate_qr_code
    end

    private

    def generate_qr_code
      RQRCode::QRCode.new(qr_code_content.gsub(/\\|"/, "")).as_png(size: 400)
    end

    def qr_code_content
      "#{[@student.identifier]};#{[@test.id]};#{[@questions.count]};#{@correct_alternatives};#{@questions_values}"
    end

    def create_correct_alternatives_list
      @correct_alternatives = []

      @questions.each do |question|
        question.alternatives.correct.each do |alternative|
          @correct_alternatives << alternative.option
        end
      end
    end

    def create_questions_values_list
      @questions_values = []

      @questions.each do |question|
        @questions_values << question.value
      end
    end
  end
end
