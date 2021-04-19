# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(attr={})
    @message = attr[:message]
    @game_room = attr[:game_room]
  end
end
