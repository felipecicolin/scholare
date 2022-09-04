# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def create
    # the user might already exist in our db or it might be a new user
    user = User.find_or_create_by!(email: params[:email])

    user.send_magic_link

    head :ok
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
