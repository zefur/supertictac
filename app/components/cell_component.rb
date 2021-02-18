# frozen_string_literal: true

class CellComponent < ViewComponent::Base
  def initialize(attributes = {})
    @cell = attributes[:cell]
    @class = attributes[:class]
    @cell_counter
  end
end
