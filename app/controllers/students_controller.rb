# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[edit update destroy]

  def index
    search = current_user.students.ransack(params[:q])
    students = search.result(distinct: true)
    render Students::Index::Component.new(students:, search:, current_user:)
  end

  def new
    student = Student.new
    render Students::New::Component.new(student:)
  end

  def edit
    render Students::Edit::Component.new(student: @student, current_user:)
  end

  def create
    student = Student.new(student_params)

    if student.save
      redirect_to students_path, notice: t("shared.notices.male.created",
                                           model: t("activerecord.models.student"))
    else
      render Students::New::Component.new(student:)
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
    params.require(:student).permit(:name, :identifier, :school_class_id).with_defaults(user_id: current_user.id)
  end
end
