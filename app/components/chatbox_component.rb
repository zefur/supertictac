# frozen_string_literal: true

class ChatboxComponent < ViewComponent::Base
  def initialize(attr = {})
    @room = attr[:room]
    @current_user = attr[:user]
  end
end
