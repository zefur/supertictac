class Computer 
attr_accessor :user_name, :board, :depth
    def initialize(atr = {})
        @board = atr[:board]
        @user_name = "H.A.L"
        @depth = 1
    end

    def make_move(game)
        # compScore = -10
        compMove = ''
        board = game.board
        empty_cells = game.cells.where(free: true)
        empty_cells.each do |cell|
            board.make_nought_move(cell)
            score = minimax(board.cpu_next_place(cell), @depth, -10, 10, true)
            board.undo(cell)
            score
            compMove = cell
        end
        # @board.games[game-1].cells.each {|x| x.free? ? empty_cells << x : ""}
        # @board.games.each do |game|
        #     game.cells.each do |cell|
        #     if cell.empty?
        #         cell.nought!
        #         cell.toggle(:empty)
        #         score = minimax(game , @depth  , true) 
        #         cell.nothing!
        #         cell.toggle(:empty)
                
        # @board.make_move(game)
        # score = minimax(@board.make_move(game), @depth, true)
        # @board.undo_move
        # compScore  = max(compScore, score)
        #         compMove = cell
        #         compMove
        compMove
    end

    SCORES = {

    }


    def copy_board
        new_board = @board.deep_dup
        new_board
    end

    def minimax(game, depth, alpha, beta, isMaximizing)
        score = -10
        if @depth == 0 
            return score
        end

        empty_cells = game.cells.where(free: true)
        if isMaximizing
            
            empty_cells.each do |cell|
                @board.make_nought_move(cell)
                newScore = minimax(board.cpu_next_place(cell), @depth - 1,alpha, beta, false)
                @board.undo(cell)
                    score = [score, newScore].max
                     alpha = max(alpha, newScore)
                    
                     if beta <= alpha 
                         break
                     end
                end
        
            score
        else
            score = 10
           empty_cells.each do |cell|
                    @board.make_cross_move(cell)
                    newScore = minimax(@board.cpu_next_place(cell), depth - 1, alpha, beta, true)
                    @board.undo(cell)
                    score = [score, newScore].min
                    beta = min(beta, newScore)
                     if alpha>= beta
                         break
                     end
                end
            
            score
        end
    end
end

