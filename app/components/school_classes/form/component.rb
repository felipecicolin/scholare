# frozen_string_literal: true

module SchoolClasses
  module Form
    class Component < ViewComponent::Base
      def initialize(school_class:, method:, url:, submit_text:, current_user:)
        @school_class = school_class
        @url = url
        @method = method
        @submit_text = submit_text
        @current_user = current_user
      end
    end
  end
end
