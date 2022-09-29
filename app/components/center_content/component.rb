# frozen_string_literal: true

module CenterContent
  class Component < ViewComponent::Base
    def initialize(width:)
      @width = width
    end

    private

    attr_reader :width
  end
end
