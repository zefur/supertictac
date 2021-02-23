class Computer < ApplicationRecord

    def initialize(atr = {})
        @board = atr[:board]
        @depth = 1
    end

    def minimax(@board, depth, isMaximizing)
        
        if isMaximizing
            score = -infinity
            game.cells.each do |cell|
                if cell.empty
                newScore = minimax(cell, depth - 1, false)
                score = max(score, newScore)
                score
            end
        else
                score = +infinity
            game.cells.each do |cell|
                newScore = minimax(cell, depth - 1, true)
                score = max(score, newScore)
                score
            end


        end
    end
end

