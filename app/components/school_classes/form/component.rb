# frozen_string_literal: true

module SchoolClasses
  module Form
    class Component < ViewComponent::Base
      def initialize(school_class:, method:, url:, submit_text:)
        @school_class = school_class
        @url = url
        @method = method
        @submit_text = submit_text
      end
    end
  end
end
