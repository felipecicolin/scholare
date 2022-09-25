# frozen_string_literal: true

module SchoolClasses
  module New
    class Component < ViewComponent::Base
      def initialize(school_class:, current_user:)
        @school_class = school_class
        @current_user = current_user
      end
    end
  end
end
