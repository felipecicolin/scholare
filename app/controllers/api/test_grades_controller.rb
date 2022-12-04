# frozen_string_literal: true

module Api
  class TestGradesController < ApplicationApiController
    def create
      test_grade = TestGrade.new(test_grade_params)

      if test_grade.save
        render json: test_grade, status: :created
      else
        render json: test_grade.errors, status: :unprocessable_entity
      end
    end

    private

    def test_grade_params
      params.require(:test_grade).permit(:grade, :test_id, :student_id)
    end
  end
end
