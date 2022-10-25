# frozen_string_literal: true

module SchoolTests
  module Edit
    class Component < ViewComponent::Base
      def initialize(student:, current_user:)
        @student = student
        @school_classes = current_user.school_classes.order(:name)
      end

      private

      attr_reader :student, :school_classes
    end
  end
end
