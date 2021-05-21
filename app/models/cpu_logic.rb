class CpuLogic


    def make_move(valid_moves, state)
        move = valid_moves.sample
        puts "LOLOLOLOLO"
        p move
        puts "hey"
            if move[0] == "nothing"
              index = move[1]
              # @count += 1
              p "meee"
              new_state = state
              p new_state
              # change the cell value
              test = new_state.find {|s| s[1] == "open" }
               test[3][index] = @cpu ?  "nought" : "cross"
               test[1] = "closed"
               new_state[test[0]-1] = test
               new_state
         
            #    if game_cross(test[3])
            #     test[2] = "cross"
            #    elsif game_nought(test[3])
            #     test[2] = "nought"
            #    end
               new_state[index][1] = "open" 
            #    @cpu = !cpu
      
              new_state
              else
                puts "this is the end"
              end
           
    end






end