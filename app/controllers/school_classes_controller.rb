# frozen_string_literal: true

class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: %i[edit update destroy]

  def index
    @school_classes = current_user.school_classes.all
  end

  def new
    @school_class = SchoolClass.new
  end

  def edit; end

  def create
    @school_class = SchoolClass.new(school_class_params)

    if @school_class.save
      redirect_to user_school_classes_path(current_user), notice: "School class was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @school_class.update(school_class_params)
      redirect_to user_school_classes_path(current_user), notice: "School class was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school_class.destroy
    redirect_to school_classes_url, notice: "School class was successfully destroyed."
  end

  private

  def set_school_class
    @school_class = current_user.school_classes.find(params[:id])
  end

  def school_class_params
    params.require(:school_class).permit(:name).with_defaults(user: current_user)
  end
end
