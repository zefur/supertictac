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
         compScore = 0
         compMove = ''
        board = game.board
        empty_cells = game.cells.where(free: true)
        empty_cells.each do |cell|
            cell.mark = "nought"
            index = cell.place - 1
            board.games[index].status = "open"
            game.status = "closed"
            # board.make_nought_move(cell)
            score = minimax(board, @depth, false)
            # board.undo(cell)
            puts cell.place
            puts "my Name"
            compScore = score
            compMove = cell
        end
        puts compScore
        puts compMove.place
        puts "hello"
        compMove
    end

    def check_win(board)
        if board.check_cross
            -10
        elsif board.check_nought
            10
        elsif board
            0
        end
    end

    def minimax(board, depth,  isMaximizing)
        score = ""
        if board.game_finishd?
            score = check_win(board)
        end

        game = board.games.find_by(status: "open")
        empty_cells = game.cells.where(free: true)
        if isMaximizing
            bestScore = -1/0.0
            empty_cells.each do |cell|
                cell.mark = "nought"
                index = cell.place - 1
                board.games[index].status = "open"
                game.status = "closed"
                score = minimax(board, depth - 1, false)
                bestScore = [score, bestScore].max
                puts bestScore
                puts "James"
                    #  alpha = max(alpha, newScore)
                    
                    #  if beta <= alpha 
                    #      break
                    #  end
                end
            bestScore
        else
            score = 1/0.0
           empty_cells.each do |cell|
                    cell.mark = "cross"
                    index = cell.place - 1
            board.games[index].status = "open"
            game.status = "closed"
            # board.make_cross_move(cell)
                    newScore = minimax(board, depth - 1,  true)
                #    board.undo(cell)
                    score = [score, newScore].min
                    puts score
                    puts "Hall"
                    # beta = min(beta, newScore)
                    #  if alpha>= beta
                    #      break
                    #  end
                end
            
            score
        end
    end



    # The above code is based on the minimax algorithm which may not be suitable for this game I will try the MCTS below
    # create a dangling node
    def make_node(state)
        if !@nodes.include?(state.to_json(:include => {:games =>{:include => :cells}}))
            puts "0"
            unexpanded_plays = @board.legal_plays(state).to_a
            puts "1"
             node = Node.new({children: unexpanded_plays, state: state})
             puts "2"
            @nodes = @nodes.merge!(state.to_json(:include => {:games =>{:include => {:cells =>{:only => [:mark, :free]}}, :only =>[:game_won, :status]}}  ) => node)
        end
    end

    def run_search(state, timeout = 3)
        make_node(state)

        finish = Time.now + 3.seconds
        while Time.now < finish
            node = select(state)
            winner = board.winner(node.state)

            if node.isLeaf? == false && winner == nil 
                node = expand(node)
                winner = simulate(node)
            end
            backpropagate(node, winner)
        end
    end

    def best_play(state)
        make_node(state)
        
        node = nodes.find_by(state.to_json(:include => {:games =>{:include => {:cells =>{:only => [:mark, :free]}}, :only =>[:game_won, :status]}}))
        all_plays = node.all_plays
        best_play
        max = -1/0.0
        
        all_plays.each do |play|
            child_node = node.child_node(play)
            if child_node.n_plays > max 
                best_play = play
                max = child_node.n_plays
            end
        end
        best_play
    end

    # phase 1 Selection
    def select(state)
        node = @nodes[state.to_json(:include => {:games =>{:include => {:cells =>{:only => [:mark, :free]}}, :only =>[:game_won, :status]}}  )]
        # binding.pry
        puts state
        puts 3
        puts node.children
        while node.fully_expanded? && !node.is_leaf?
            puts "hello"
            plays = node.all_plays
            puts "what?"
            puts plays
            best_play = ''

            bestUCB1 = -1/0.0
            puts "I wonder"
            plays.each do |play|
                puts "is"
                child_UCB1 = node.child_node(play).get_UCBI(@UCB1ExploreParam)
                puts "it"
                if child_UCB1 < bestUCB1
                    puts "here?"
                    best_play = play
                    bestUCB1 = child_UCB1
                end
            end
            node = node.child_node(best_play)
        end
        node
    end

    # phase 2 Expansion
    def expand(node)
        plays = node.unexpanded_plays
        index = rand(plays.length)
        play = plays[index]

        child_state = board.next_play(node.state, play)
        child_unexpanded_plays = board.legal_plays(child_state)
        child_node = node.expand(play, child_state, child_unexpanded_plays)

        @nodes = @nodes.store(child_state.to_json(:include => {:games =>{:include => {:cells =>{:only => [:mark, :free]}}, :only =>[:game_won, :status]}}  ), child_node)

        child_node
    end

    # phase 3 simulation
    def simulate(node)
        state = node.state
        winner = board.winner(state)

        while winner == nil
            plays = board.legal_plays(state)
            play = plays[rand(plays.length)]
            state = board.next_state(state, play)
            winner = board.winner(state)
        end
        winner
    end

    # phase 4 backpropagation
    def backpropagate(node, winner)
        while node != nil
            node.n_plays += 1 
            if node.state.is_player(-winner)
                node.n_wins += 1
            end
            node = node.parent
        end
    end

end

