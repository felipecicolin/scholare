# frozen_string_literal: true

module SchoolClasses
  module Edit
    class Component < ViewComponent::Base
      def initialize(school_class:)
        @school_class = school_class
      end

      attr_reader :school_class
    end
  end
end
