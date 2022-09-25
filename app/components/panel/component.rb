# frozen_string_literal: true

module Panel
  class Component < ViewComponent::Base
    def initialize(current_user:)
      @current_user = current_user
    end
  end
end
