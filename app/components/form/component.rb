# frozen_string_literal: true

module Form
  class Component < ViewComponent::Base
    def initialize(resource:, form_fields:, method:, url:)
      @resource = resource
      @form_fields = form_fields
      @url = url
      @method = method
    end

    private

    def submit_button_text
      create_text || edit_text
    end

    def create_text
      I18n.t("shared.buttons.create") if @resource.new_record?
    end

    def edit_text
      I18n.t("shared.buttons.edit") if @resource.persisted?
    end
  end
end
