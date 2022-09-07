# frozen_string_literal: true

module Nav
  class Component < ViewComponent::Base
    def initialize(current_account:)
      @current_account = current_account
    end
  end
end
