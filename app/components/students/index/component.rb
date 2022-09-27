# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      def initialize(students:, school_classes:)
        @students = students
        @school_classes = school_classes
      end

      private

      attr_reader :students, :school_classes
    end
  end
end
