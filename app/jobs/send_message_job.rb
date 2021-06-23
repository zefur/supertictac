class SendMessageJob < ApplicationJob
    include CableReady::Broadcaster
    queue_as :default

    def perform(message)
        puts @game_room
        puts "testing"
        puts message
        # binding.pry
        html =  ApplicationController.render(MessageComponent.new(message: message)) 
        cable_ready[GameRoomChannel].insert_adjacent_html(
            selector:  '#chat-area',
            position: "beforeend",
            html:  html
        ).broadcast_to(message.game_room)
    end

end