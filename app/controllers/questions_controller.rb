# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :handle_school_tests_missing
  before_action :set_question, only: %i[edit update destroy]

  def index
    search_query = current_user.questions.ransack(params[:q])
    search_result = search_query.result(distinct: true)
    pagy, questions = pagy(search_result)
    render Questions::Index::Component.new(search_query:, pagy:, questions:, current_user:)
  end

  def new
    question = Question.new
    render Questions::New::Component.new(question:, current_user:)
  end

  def edit
    render Questions::Edit::Component.new(question: @question, current_user:)
  end

  def create
    question = Question.new(question_params)

    if question.save
      redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.created",
                                                                            model: t("activerecord.models.question"))
    else
      render Questions::New::Component.new(question:, current_user:)
    end
  end

  def update
    if @question.update(question_params)
      redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.updated",
                                                                            model: t("activerecord.models.question"))
    else
      render Questions::Edit::Component.new(question: @question, current_user:)
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.destroyed",
                                                                          model: t("activerecord.models.question"))
  end

  private

  def handle_school_tests_missing
    redirect_to root_path, alert: t("questions.alert.no_school_classes") unless current_user.tests.any?
  end

  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :value, :test_id).with_defaults(user_id: current_user.id,
                                                                            test_id: params[:test_id])
  end
end
