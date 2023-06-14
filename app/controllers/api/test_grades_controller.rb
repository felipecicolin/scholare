# frozen_string_literal: true

module Api
  class TestGradesController < ApplicationApiController
    def create
      test_grade = TestGrade.new(grade: params[:grade], test_id: params[:test_id], student_id: params[:student_id])

      if test_grade.save
        render json: { test_grade: test_grade.grade }, status: :created
      else
        render json: { errors: test_grade.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
