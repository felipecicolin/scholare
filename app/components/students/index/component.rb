# frozen_string_literal: true

module Students
  module Index
    class Component < ViewComponent::Base
      include Ransack::Helpers::FormHelper
      include Pagy::Frontend

      def initialize(search_query:, school_classes:, pagy:, students:)
        @search_query = search_query
        @school_classes = school_classes.order(:name)
        @pagy = pagy
        @students = students.order(:name)
      end

      private

      attr_reader :search_query, :school_classes, :pagy, :students
    end
  end
end
