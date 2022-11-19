# frozen_string_literal: true

module SchoolTests
  module New
    class Component < ViewComponent::Base
      def initialize(test:, current_user:)
        @test = test
        @school_classes = current_user.school_classes.order(:name)
      end

      private

      attr_reader :test, :school_classes
    end
  end
end
