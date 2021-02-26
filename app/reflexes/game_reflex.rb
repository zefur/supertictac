# frozen_string_literal: true

class GameReflex < ApplicationReflex
  delegate :current_or_guest_user, to: :connection
  delegate :session_id, to: :connection
  before_reflex :set_game_room, :info
  after_reflex :game_won, :game_over
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

    @cell = Cell.find(element.dataset['cell-id'])
    @board = @game_room.board
    @players = @game_room.players
    # This gives a number from 1-9 to reference a game in the board by position
    @index = @cell.place 
    # this finds the actual game by ID
    @old_game = Game.find(@cell.game_id)

    if current_or_guest_user == @players[0] && @game_room.player1?
     @board.make_cross_move(@cell) 
     
      # makes a game active and deactivates the previous game square
      # @game_room.board.games[@index - 1].open!
      # @old_game.closed!
      
      # places mark
      # @cell.cross!
      # @cell.toggle(:empty)

      # this updates the page and shows the changes and broadcasts it to the people in the room
      morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell }))
      cable_ready[GameRoomChannel].add_css_class(
        selector: "#cell_#{@cell.id}",
        name: 'x'
      ).broadcast_to(@game_room)
      next_area
      #  @game_room.player2!
       cpu 
    elsif current_or_guest_user == @players[1] && @game_room.player2?
      # @game_room.players[1].compMove.nought!
      @cell.nought!
      @cell.toggle(:free)
      @game_room.board.games[@index - 1].open!
      @old_game.closed!
      morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell, class: 'circle' }))
      cable_ready[GameRoomChannel].add_css_class(
        selector: "#cell_#{@cell.id}",
        name: 'circle'
      ).broadcast_to(@game_room)
      next_area
      @game_room.player1!
    end
  # end
  end

  def game_over
    
    if @game_room.board.check_cross
      @message = "Crosses have won the game"
    elsif @game_room.board.check_nought
      @message = "Noughts have won the game"
    end

  end

  def game_won
    # checks if a game quadrant has been won (cableready highlighting lost on refresh)
    @game_room.board.games.each do |x|
      if x.check_cross
        x.cross!
        cable_ready[GameRoomChannel].add_css_class(
          selector: "#game_#{x.place}",
          name: 'bg-red-300'
        ).broadcast_to(@game_room)
      elsif x.check_nought
        x.nought!
        cable_ready[GameRoomChannel].add_css_class(
          selector: "#game_#{x.place}",
          name: 'bg-green-300'
        ).broadcast_to(@game_room)
      end
    end
  end

  def start_game
    if @game_room.players.count == 2
      @game_room.start
    else
      cpu = Computer.new( {board: @game_room.board})
      @game_room.players << cpu
      @game_room.save
      @game_room.start
      
    end
    
  end

  def restart_game
    # this works but want to move all CR to the models and autobroadcast on update
    @game_room.restart
    cable_ready[GameRoomChannel].morph(
      selector: '#why',
      children_only: true,
      html: render(BoardComponent.new(board: @game_room.board))
    ).broadcast_to(@game_room)
  end

  private

  def set_game_room
    @game_room = GameRoom.find(params[:id])
  end

  def cpu

     @game_room.board.make_move_computer
    
    # ComputerMoveJob.perform_later
    # @cell.toggle(:free)
    # @game_room.board.games[@index - 1].open!
    # @old_game.closed!
    # morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell, class: 'circle' }))
    # cable_ready[GameRoomChannel].add_css_class(
    #   selector: "#cell_#{@cell.id}",
    #   name: 'circle'
    # ).broadcast_to(@game_room)
    # next_area
    @game_room.player1!
  end

def info
  puts @game_room.board.games.ids
  puts @game_room.board.games.each {|x| x.place}
end

  def next_area
    cable_ready[GameRoomChannel].remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: 'ring-4'
    ).remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: 'active'
    ).add_css_class(
      selector: '#test',
      name: 'inactive'
    ).add_css_class(
      selector: "#game_#{@index}",
      name: 'active'
    ).add_css_class(
      selector: "#game_#{@index}",
      name: 'ring-4'
    ).broadcast_to(@game_room)
  end
end
