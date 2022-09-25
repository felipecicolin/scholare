# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[edit update destroy]

  def index
    students = current_user.students.all
    render Students::Index::Component.new(students:, current_user:)
  end

  def new
    student = Student.new
    render Students::New::Component.new(student:, current_user:)
  end

  def edit
    render Students::Edit::Component.new(student: @student, current_user:)
  end

  def create
    student = Student.new(student_params)

    if student.save
      redirect_to user_students_path(current_user), notice: t("shared.notices.female.created",
                                                              model: t("activerecord.models.student"))
    else
      render Students::New::Component.new(student:, current_user:)
    end
  end

  def update
    if @student.update(student_params)
      redirect_to user_students_path(current_user), notice: t("shared.notices.female.updated",
                                                              model: t("activerecord.models.student"))
    else
      render Students::Edit::Component.new(student: @student, current_user:)
    end
  end

  def destroy
    @student.destroy
    redirect_to user_students_path(current_user), notice: t("shared.notices.female.destroyed",
                                                            model: t("activerecord.models.student"))
  end

  private

  def set_student
    @student = current_user.students.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name).with_defaults(user_id: current_user.id)
  end
end
