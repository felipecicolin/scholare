# frozen_string_literal: true

class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: %i[edit update destroy]

  def index
    school_classes = current_user.school_classes.all
    render SchoolClasses::Index::Component.new(school_classes:, current_user:)
  end

  def new
    school_class = SchoolClass.new
    render SchoolClasses::New::Component.new(school_class:, current_user:)
  end

  def edit
    render SchoolClasses::Edit::Component.new(school_class: @school_class, current_user:)
  end

  def create
    school_class = SchoolClass.new(school_class_params)

    if school_class.save
      redirect_to user_school_classes_path(current_user), notice: t("shared.notices.female.created",
                                                                    model: t("activerecord.models.school_class"))
    else
      render SchoolClasses::New::Component.new(school_class:, current_user:)
    end
  end

  def update
    if @school_class.update(school_class_params)
      redirect_to user_school_classes_path(current_user), notice: t("shared.notices.female.updated",
                                                                    model: t("activerecord.models.school_class"))
    else
      render SchoolClasses::Edit::Component.new(school_class: @school_class, current_user:)
    end
  end

  def destroy
    @school_class.destroy
    redirect_to user_school_classes_path(current_user), notice: t("shared.notices.female.destroyed",
                                                                  model: t("activerecord.models.school_class"))
  end

  private

  def set_school_class
    @school_class = current_user.school_classes.find(params[:id])
  end

  def school_class_params
    params.require(:school_class).permit(:name).with_defaults(user_id: current_user.id)
  end
end
