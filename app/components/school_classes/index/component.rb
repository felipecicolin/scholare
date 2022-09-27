# frozen_string_literal: true

module SchoolClasses
  module Index
    class Component < ViewComponent::Base
      def initialize(school_classes:)
        @school_classes = school_classes
      end
    end
  end
end
