# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      def initialize(school_classes:, current_user:)
        @school_classes = school_classes
        @current_user = current_user
      end
    end
  end
end
