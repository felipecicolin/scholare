# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      include Ransack::Helpers::FormHelper

      def initialize(students:, search:, current_user:)
        @students = students
        @search = search
        @current_user = current_user
      end

      private

      attr_reader :students, :search, :current_user
    end
  end
end
