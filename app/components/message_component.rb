# frozen_string_literal: true

class MessageComponent < ViewComponent::Base

    def initialize( attr={})
        @message = attr[:message]
    end


end
