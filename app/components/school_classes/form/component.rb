# frozen_string_literal: true

module SchoolClasses
  module Form
    class Component < ViewComponent::Base
      def initialize(school_class:, method:, url:, submit_button_text:, current_user:)
        @school_class = school_class
        @url = url
        @method = method
        @submit_button_text = submit_button_text
        @current_user = current_user
      end
    end
  end
end
