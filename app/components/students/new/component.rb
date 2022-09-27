# frozen_string_literal: true

module Students
  module New
    class Component < ViewComponent::Base
      def initialize(student:, current_user:)
        @student = student
        @current_user = current_user
      end
    end
  end
end
