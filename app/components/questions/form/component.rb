# frozen_string_literal: true

module Questions
  module Form
    class Component < ViewComponent::Base
      def initialize(resource:, tests:, url:, method:)
        @resource = resource
        @tests = tests
        @url = url
        @method = method
      end

      private

      attr_reader :resource, :tests, :url, :method
    end
  end
end
