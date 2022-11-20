# frozen_string_literal: true

module Questions
  module New
    class Component < ViewComponent::Base
      def initialize(question:, current_user:)
        @question = question
        @tests = current_user.tests.order(:name)
      end

      private

      attr_reader :question, :tests
    end
  end
end
