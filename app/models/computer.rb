class Computer 
attr_accessor :user_name, :board, :depth
    def initialize(attr = { UCB1ExploreParam: 2})
        @board = attr[:board]
        @user_name = "H.A.L"
        @depth = 20
        @UCB1ExploreParam = attr[:UCB1ExploreParam]
        @nodes = Hash.new
    end

    def make_move(game)

        empty_cells = game.cells.where(free: true)
        empty_cells.sample
       
    end


end

