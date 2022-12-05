# frozen_string_literal: true

module FormActions
  class Component < ViewComponent::Base
    def initialize(form_object:, back_path:)
      @form_object = form_object
      @back_path = back_path
    end

    private

    attr_reader :form_object, :back_path
  end
end
