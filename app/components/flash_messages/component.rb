# frozen_string_literal: true

module FlashMessages
  class Component < ViewComponent::Base
    def initialize(notice:, alert:)
      @notice = notice
      @alert = alert
    end

    attr_reader :notice, :alert
  end
end
