# frozen_string_literal: true

module Questions
  module Index
    class Component < ViewComponent::Base
      include Ransack::Helpers::FormHelper
      include Pagy::Frontend

      def initialize(search_query:, pagy:, questions:, current_user:)
        @search_query = search_query
        @tests = current_user.tests.order(:name)
        @pagy = pagy
        @questions = questions.order(:test_id, :body)
      end

      private

      attr_reader :search_query, :tests, :pagy, :questions
    end
  end
end
