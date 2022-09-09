# frozen_string_literal: true

module Nav
  class Component < ViewComponent::Base
    def initialize(current_user:)
      @current_user = current_user
    end
  end
end
