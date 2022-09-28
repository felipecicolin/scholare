# frozen_string_literal: true

module Students
  module New
    class Component < ViewComponent::Base
      def initialize(student:)
        @student = student
      end

      private

      attr_reader :student
    end
  end
end
