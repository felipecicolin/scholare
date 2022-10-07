# frozen_string_literal: true

module SchoolClasses
  module Form
    class Component < ViewComponent::Base
      def initialize(resource:)
        @resource = resource
      end

      private

      attr_reader :resource
    end
  end
end
