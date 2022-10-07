# frozen_string_literal: true

module FormActions
  class Component < ViewComponent::Base
    def initialize(form_object:)
      @form_object = form_object
    end

    private

    attr_reader :form_object
  end
end
