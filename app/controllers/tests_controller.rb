# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :handle_school_classes_missing
  before_action :set_test, only: %i[edit update destroy]

  def index
    search_query = current_user.tests.ransack(params[:q])
    search_result = search_query.result(distinct: true)
    pagy, tests = pagy(search_result)
    render SchoolTests::Index::Component.new(search_query:, pagy:, tests:, current_user:)
  end

  def new
    test = Test.new

    render SchoolTests::New::Component.new(test:, current_user:)
  end

  def edit
    render SchoolTests::Edit::Component.new(test: @test, current_user:)
  end

  def create
    test = Test.new(test_params)

    if test.save
      redirect_to tests_path, notice: t("shared.notices.female.created",
                                        model: t("activerecord.models.test"))
    else
      render SchoolTests::New::Component.new(test:, current_user:)
    end
  end

  def update
    if @test.update(test_params)
      redirect_to tests_path, notice: t("shared.notices.female.updated",
                                        model: t("activerecord.models.test"))
    else
      render SchoolTests::Edit::Component.new(test: @test, current_user:)
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path, notice: t("shared.notices.female.destroyed",
                                      model: t("activerecord.models.test"))
  end

  private

  def handle_school_classes_missing
    redirect_to root_path, alert: t("tests.alert.no_school_classes") unless current_user.school_classes.any?
  end

  def set_test
    @test = current_user.tests.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:name, :test_date, :value, :school_class_id).with_defaults(user: current_user)
  end
end
