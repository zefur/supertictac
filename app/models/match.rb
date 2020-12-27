class Match < ApplicationRecord

    def place_mark(player)
        cable_ready["game_room_#{game_room_id}"].add_css_class(
            selector: "#cell_#{@cell.id}", 
            name: "#{player.mark == "x" ? "x" : "circle"}"
          )
    end

    def next_move
        @game = Game.find(element.dataset["cell-id"]
        @old_game = Game.find(element.dataset["game_id"])
        cable_ready["game_room_#{game_room.id}"].remove_css_class(
            selector: "#game_#{@old_game.game_id}",
            name: "bg-blue-300"
        )
        cable_ready["game_room_#{game_room.id}"].add_css_class(
            selector: "#game_#{@game.game_id}",
            name: "bg-blue-300"
        )
        
    end

    def swap_turns
        
    end
end