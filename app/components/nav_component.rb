# frozen_string_literal: true

class NavComponent < ViewComponent::Base
  include CurrentUserConcern
  def initialize(attr = {})
    @current_user = attr[current_user]
  end
end
