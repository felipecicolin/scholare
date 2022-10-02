# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      render Panel::Component.new
    else
      render Heroe::Component.new
    end
  end
end
