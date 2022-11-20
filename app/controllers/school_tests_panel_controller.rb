# frozen_string_literal: true

class SchoolTestsPanelController < ApplicationController
  def index
    render SchoolTestsPanel::Component.new
  end
end
