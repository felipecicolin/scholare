# frozen_string_literal: true

module SchoolTests
  module Index
    class Component < ViewComponent::Base
      include Pagy::Frontend
      include Ransack::Helpers::FormHelper

      def initialize(search_query:, pagy:, tests:, current_user:)
        @search_query = search_query
        @school_classes = current_user.school_classes.order(:name)
        @pagy = pagy
        @tests = tests.order(:name)
      end

      private

      attr_reader :search_query, :school_classes, :pagy, :tests
    end
  end
end
