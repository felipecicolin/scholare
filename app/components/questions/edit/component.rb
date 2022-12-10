# frozen_string_literal: true

module Questions
  module Edit
    class Component < ViewComponent::Base
      def initialize(question:, current_user:)
        @question = question
        @tests = current_user.tests
      end

      private

      attr_reader :question, :tests
    end
  end
end
