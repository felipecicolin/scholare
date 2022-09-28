# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  def index
    students_search = current_user.students.ransack(params[:q])
    students = students_search.result(distinct: true)
    render Students::Index::Component.new(students:, students_search:, current_user:)
  end

  def new
    student = Student.new
    render Students::New::Component.new(student:)
  end

  def edit
    render Students::Edit::Component.new(student: @student, current_user:)
  end

  def show
    @student
  end

  def create
    student = Student.new(student_params)

    if student.save
      redirect_to students_path, notice: t("shared.notices.male.created",
                                           model: t("activerecord.models.student"))
    else
      render Students::New::Component.new(student:, current_user:)
    end
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, notice: t("shared.notices.male.updated",
                                           model: t("activerecord.models.student"))
    else
      render Students::Edit::Component.new(student: @student, current_user:)
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: t("shared.notices.male.destroyed",
                                         model: t("activerecord.models.student"))
  end

  private

  def set_student
    @student = current_user.students.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :identifier, :school_class_id)
  end
end
