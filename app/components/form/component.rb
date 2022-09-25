# frozen_string_literal: true

module Form
  class Component < ViewComponent::Base
    def initialize(resource:, form_attributes:, method:, url:, submit_button_text:, back_button_url:) # rubocop:disable Metrics/ParameterLists
      @resource = resource
      @form_attributes = form_attributes
      @url = url
      @method = method
      @submit_button_text = submit_button_text
      @back_button_url = back_button_url
    end
  end
end
