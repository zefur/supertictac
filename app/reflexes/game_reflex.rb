# frozen_string_literal: true

class GameReflex < ApplicationReflex
  delegate :current_or_guest_user, to: :connection
  delegate :session_id, to: :connection
  before_reflex :set_game_room
  after_reflex :game_won
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes
  def click
    # this is very messy could do with some tidying up but more/less works as planned
    
    @cell = Cell.find(element.dataset["cell-id"])
    @players = @game_room.players
    @game = Game.find(@cell.place)
    @old_game = Game.find(@cell.game_id)
   
    if current_or_guest_user == @players[0] && @game_room.player1?
      
      @game_room.board.games[@game.id-1].open!
     @old_game.closed!
     @cell.cross!
         morph "#cell_#{@cell.id}", render(CellComponent.new({cell: @cell}))
        cable_ready[GameRoomChannel].add_css_class(
        selector: "#cell_#{@cell.id}",
        name: "x",
      ).broadcast_to(@game_room)
      @game_room.player2!
    elsif current_or_guest_user == @players[1] && @game_room.player2?
      @cell.nought!
      @game_room.board.games[@game.id-1].open!
     @old_game.closed!
     
      morph "#cell_#{@cell.id}", render(CellComponent.new({cell: @cell, class: "circle"}))
      cable_ready[GameRoomChannel].add_css_class(
            selector: "#cell_#{@cell.id}",
            name: "circle",
      ).broadcast_to(@game_room)
     @game_room.player1!
    end
    
    # activates the next play area and deactivates all others (cableready highlighting lost on refresh)
    cable_ready[GameRoomChannel].remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: "ring-4",
    ).add_css_class(
      selector: "#test",
      name: "inactive",
    ).add_css_class(
      selector: "#game_#{@game.place}",
      name: "active",
    ).remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: "active",
    ).add_css_class(
      selector: "#game_#{@game.place}",
      name: "ring-4",
    ).broadcast_to(@game_room)

    
  end

  def game_won
    # checks if a game quadrant has been won (cableready highlighting lost on refresh)
    @game_room.board.games.each do |x|
      
      if x.check_cross
         x.cross! 
        cable_ready[GameRoomChannel].add_css_class(
        selector: "#game_#{x.place}",
        name: "bg-red-300",
        ).broadcast_to(@game_room)
      elsif x.check_nought
        x.nought!
        cable_ready[GameRoomChannel].add_css_class(
          selector: "#game_#{x.place}",
          name: "bg-green-300",
          ).broadcast_to(@game_room)
      end
    end
  
  end

  def restart_game
    # this works but want to move all CR to the models and autobroadcast on update
    @game_room.restart
    cable_ready[GameRoomChannel].morph(
      selector: "#why",
      children_only: true,
      html: render(BoardComponent.new(board: @game_room.board))
    ).broadcast_to(@game_room)
  end

  private

  def set_game_room
    @game_room = GameRoom.find(params[:id])
  end

  

end
