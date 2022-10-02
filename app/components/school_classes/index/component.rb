# frozen_string_literal: true

module SchoolClasses
  module Index
    class Component < ViewComponent::Base
      include Pagy::Frontend

      def initialize(school_classes:, pagy:)
        @school_classes = school_classes.order(:name)
        @pagy = pagy
      end

      attr_reader :school_classes, :pagy
    end
  end
end
