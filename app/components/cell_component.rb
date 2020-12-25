# frozen_string_literal: true

class CellComponent < ViewComponent::Base
  def initialize(attributes = {})
    @cell = attributes[:cell]
    @message = attributes[:message]
    @cell_counter
  end
end
