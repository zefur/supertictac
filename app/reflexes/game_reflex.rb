# frozen_string_literal: true

class GameReflex < ApplicationReflex
  delegate :current_or_guest_user, to: :connection
  delegate :session_id, to: :connection
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
    

    @cell.choice
    # The code here (43-69) has been refactored but is and should be deleted but when its deleted the highlighting stops working. 
    if @cell.cross?
      morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell }))
      cable_ready.remove_css_class(
        selector: "#cell_#{@cell.id}",
        name: "m"
      )
      cable_ready.add_css_class(
      selector: "#cell_#{@cell.id}",
      name: 'x'
    )
    elsif @cell.nought?
      morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell }))
      cable_ready.remove_css_class(
        selector: "#cell_#{@cell.id}",
        name: 'x'
      )
      cable_ready.add_css_class(
        selector: "#cell_#{@cell.id}",
        name: 'circle'
      )
    elsif @cell.nothing?
      morph "#cell_#{@cell.id}", render(CellComponent.new({ cell: @cell }))
      cable_ready.remove_css_class(
        selector: "#cell_#{@cell.id}",
        name: 'circle'
      )
    end
    # 
    
    @game = Game.find(@cell.place)
    @old_game = Game.find(@cell.game_id)
 
    game_room = GameRoom.find(params[:id])
    cable_ready.remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: 'bg-blue-300'
    ).add_css_class(
      selector: "#test",
      name: "inactive"
    ).add_css_class(
      selector: "#game_#{@game.place}",
      name: "active"
    ).remove_css_class(
      selector: "#game_#{@old_game.place}",
      name: "active"
    )
   
    cable_ready[GameRoomChannel].add_css_class(
      selector: "#game_#{@game.place}",
      name: 'bg-blue-300'
    ).broadcast_to(game_room)
  end
end
