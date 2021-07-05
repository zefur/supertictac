class ChatReflex < ApplicationReflex
  delegate :current_user, to: :connection
  delegate :session_id, to: :connection
  before_reflex :set_game_room 
  def post

    puts params
puts "+++++++++++++++++++++++++++++++++++++++++++++++++++"
    chat = Message.new(content: params[:content]  , game_room_id: @game_room.id, user_id: current_user.id)
     chat.save
    # cable_ready[GameRoomChannel].insert_adjacent_html(
    #   selector: '#chat-area',
    #   html: render(MessageComponent.new(message: chat, user: current_user))
    # ).broadcast_to(@game_room)
        morph '#hello', render(ChatboxComponent.new(room: @game_room, user: current_user))

  end

  private

  def set_game_room
    @game_room = GameRoom.friendly.find(params[:id])
  end

  def chat_params
    params.require(:message).permit(:content)
  end
end
