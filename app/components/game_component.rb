# frozen_string_literal: true

class GameComponent < ViewComponent::Base
  include ViewComponent::SlotableV2

  renders_many :units, UnitComponent

  def initialize(attributes = {})
    @game = attributes[:game]
  end
  # class CellComponent < ViewComponent::Base
  #     def initialize(attributes = {})
  #        @cell = attributes[:cell]
  #        @message = attributes[:message]
  #        @cell_counter
  #     end
  # end
end
