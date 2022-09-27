# frozen_string_literal: true

module Form
  class Component < ViewComponent::Base
    def initialize(resource:, form_fields:, url:)
      @resource = resource
      @form_fields = form_fields
      @url = url
    end

    private

    attr_reader :resource, :form_fields, :url

    def create_or_edit
      I18n.t("shared.buttons.create") if @resource.new_record?
      I18n.t("shared.buttons.edit") if @resource.persisted?
    end

    def post_or_patch
      :post if @resource.new_record?
      :patch if @resource.persisted?
    end
  end
end
