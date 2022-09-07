# frozen_string_literal: true

module FlashMessages
  class Component < ViewComponent::Base
    def initialize(notice:, alert:)
      @notice = notice
      @alert = alert
    end
  end
end
