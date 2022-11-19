# frozen_string_literal: true

module SchoolTests
  module Form
    class Component < ViewComponent::Base
      def initialize(resource:, school_classes:)
        @resource = resource
        @school_classes = school_classes
      end

      private

      attr_reader :resource, :school_classes
    end
  end
end
