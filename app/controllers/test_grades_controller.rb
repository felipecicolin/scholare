# frozen_string_literal: true

class TestGradesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @student = Student.find_by(identifier: params[:identifier])
    @test_grades = @student&.test_grades
  end
end
