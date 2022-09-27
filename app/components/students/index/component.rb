# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      def initialize(students:, current_user:)
        @students = students
        @current_user = current_user
      end
    end
  end
end
