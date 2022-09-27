# frozen_string_literal: true

module SchoolClasses
  module New
    class Component < ViewComponent::Base
      def initialize(school_class:)
        @school_class = school_class
      end
    end
  end
end
