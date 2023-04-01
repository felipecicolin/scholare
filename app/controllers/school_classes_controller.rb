# frozen_string_literal: true

class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: %i[edit update destroy]

  def index
    @pagy, @school_classes = pagy(current_user.school_classes)
  end

  def new
    @school_class = SchoolClass.new
  end

  def edit; end

  def create
    @school_class = SchoolClass.new(school_class_params)

    if @school_class.save
      redirect_to school_classes_path, notice: t("shared.notices.female.created",
                                                 model: t("activerecord.models.school_class"))
    else
      render :new
    end
  end

  def update
    if @school_class.update(school_class_params)
      redirect_to school_classes_path, notice: t("shared.notices.female.updated",
                                                 model: t("activerecord.models.school_class"))
    else
      render :edit
    end
  end

  def destroy
    @school_class.destroy
    redirect_to school_classes_path, notice: t("shared.notices.female.destroyed",
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
