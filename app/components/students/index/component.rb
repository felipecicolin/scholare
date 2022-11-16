# frozen_string_literal: true

module Students
  module Index
    class Component < ApplicationComponent
      include Pagy::Frontend

      def initialize(search_query:, pagy:, students:, current_user:)
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
