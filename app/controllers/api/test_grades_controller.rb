# frozen_string_literal: true

module Api
  class TestGradesController < ApplicationApiController
    before_action :ensure_test_grade_params_are_present, only: :create

    def create
      test_grade = TestGrade.find_or_initialize_by(test_id: params[:test_id], student_id: params[:student_id])
      test_grade.grade = params[:grade]

      if test_grade.save
        render json: { test_grade: test_grade.grade }, status: :created
      else
        render json: { errors: test_grade.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def ensure_test_grade_params_are_present
      return if params[:grade].present? && params[:test_id].present? && params[:student_id].present?

      render json: { errors: I18n.t("api.test_grades.missing_params") }, status: :bad_request
    end
  end
end
