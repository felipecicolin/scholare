# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :handle_school_classes_missing
  before_action :set_student, only: %i[edit update destroy]

  def index
    search_query = current_user.students.ransack(params[:q])
    search_result = search_query.result(distinct: true)
    pagy, students = pagy(search_result)
    render Students::Index::Component.new(search_query:, pagy:, students:, current_user:)
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

  def handle_school_classes_missing
    redirect_to root_path, alert: t("students.alert.no_school_classes") unless current_user.school_classes.any?
  end

  def set_student
    @student = current_user.students.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :identifier, :school_class_id).with_defaults(user_id: current_user.id)
  end
end
