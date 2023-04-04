# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[edit update destroy]

  def index
    test_questions = current_user.questions.where(test_id: params[:test_id])
    @pagy, @questions = pagy(test_questions)
  end

  def new
    @question = Question.new

    %w[A B C D E].each do |option|
      @question.alternatives.build(option:)
    end
  end

  def edit; end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.created",
                                                                            model: t("activerecord.models.question"))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.updated",
                                                                            model: t("activerecord.models.question"))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(test_id: params[:test_id]), notice: t("shared.notices.female.destroyed",
                                                                          model: t("activerecord.models.question"))
  end

  private

  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :value, alternatives_attributes: %i[id body correct option]).with_defaults(
      user_id: current_user.id, test_id: params[:test_id]
    )
  end
end
