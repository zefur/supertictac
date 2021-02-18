# frozen_string_literal: true

class GameComponent < ViewComponent::Base
  

  def initialize(attributes = {})
    @game = attributes[:game]
  end
  
end
