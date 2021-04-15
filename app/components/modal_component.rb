# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end
end
