# frozen_string_literal: true

module Questions
  module Index
    class Component < ViewComponent::Base
      include Pagy::Frontend

      def initialize(pagy:, questions:, current_user:)
        @tests = current_user.tests
        @pagy = pagy
        @questions = questions.order(:test_id, :body)
      end

      private

      attr_reader :tests, :pagy, :questions
    end
  end
end
