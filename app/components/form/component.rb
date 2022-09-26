# frozen_string_literal: true

module Form
  class Component < ViewComponent::Base
    def initialize(resource:, form_fields:, url:)
      @resource = resource
      @form_fields = form_fields
      @url = url
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

    def form_method
      patch_method || post_method
    end

    def patch_method
      :patch if @resource.persisted?
    end

    def post_method
      :post if @resource.new_record?
    end
  end
end
