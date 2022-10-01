# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      require "pagy/extras/bootstrap"

      include Ransack::Helpers::FormHelper
      include Pagy::Frontend

      def initialize(search_query:, current_user:, pagy:, students:)
        @search_query = search_query
        @school_classes = current_user.school_classes.order(:name)
        @pagy = pagy
        @students = students.order(:name)
      end

      private

      attr_reader :search_query, :school_classes, :pagy, :students
    end
  end
end
