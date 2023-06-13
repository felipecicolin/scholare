# frozen_string_literal: true

module Api
  class MobileSessionsController < ApplicationApiController
    before_action :ensure_email_and_password_are_present, only: :create
    before_action :ensure_email_and_auth_token_are_present, only: %i[show destroy]

    def show
      user = User.find_by(email: params[:email], auth_token: params[:auth_token])

      if user.present?
        render json: { message: I18n.t("api.mobile_sessions.user_is_logged_in") }
      else
        render json: { error: I18n.t("api.mobile_sessions.invalid_email_or_auth_token") }, status: :unauthorized
      end
    end

    def create
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        user.regenerate_auth_token
        render json: { auth_token: user.auth_token }
      else
        render json: { error: I18n.t("api.mobile_sessions.invalid_email_or_password") }, status: :unauthorized
      end
    end

    def destroy
      user = User.find_by(email: params[:email], auth_token: params[:auth_token])

      if user.present?
        user.update(auth_token: nil)
        render json: { message: I18n.t("api.mobile_sessions.logout_successfull") }
      else
        render json: { error: I18n.t("api.mobile_sessions.invalid_email_or_auth_token") }, status: :unauthorized
      end
    end

    private

    def ensure_email_and_password_are_present
      return if params[:email] && params[:password]

      render json: { error: I18n.t("api.mobile_sessions.email_and_password_are_required") }, status: :bad_request
    end

    def ensure_email_and_auth_token_are_present
      return if params[:email] && params[:auth_token]

      render json: { error: I18n.t("api.mobile_sessions.email_and_auth_token_are_required") }, status: :bad_request
    end
  end
end
