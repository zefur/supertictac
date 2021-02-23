# frozen_string_literal: true

class BoardComponent < ViewComponent::Base
  def initialize(attributes = {})
    @board = attributes[:board]
  end
end
