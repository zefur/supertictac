class Node
    attr_accessor :play, :state, :n_plays, :n_wins, :parent, :children
    def initialize(attr = {})
       
        @play = attr[:play]
        @state = attr[:state]
        

        # computer
        @n_plays = 0
        @n_wins = 0

        # tree
         @parent = attr[:parent]
         @children = attr[:children].map do |play|
            Hash[[[play.to_json({:only => [:mark, :free]}) , {play: play, node: nil}]]]
         end
    end

    def child_node(play)
        puts @children
        puts play.to_json
        child = @children.find {|x| x["{\"free\":true,\"mark\":\"nothing\"}"][:play].to_json == play.to_json}
        puts 1
        puts child
        child["{\"free\":true,\"mark\":\"nothing\"}"][:node]
    end

    def expand(play, child_state, unexpanded_plays)
        child_node = Node.new({parent: self, play: play, state: child_state, children: unexpanded_plays}    )
        self.children.merge!(play.to_json(:include => {:games =>{:include => {:cells =>{:only => [:mark, :free]}}, :only =>[:game_won, :status]}}), {play:play, node: child_node})
        child_node
    end
    
    def all_plays 
        ret = []
        self.children.each do |child|
            ret << child["{\"free\":true,\"mark\":\"nothing\"}"][:play]
        end
        ret
    end

    def unexpanded_plays
        ret = []
        self.children.each do |child|
            if child["{\"free\":true,\"mark\":\"nothing\"}"][:node] == nil 
                ret << child["{\"free\":true,\"mark\":\"nothing\"}"][:play]
            end
        end
    end

    def fully_expanded?
        self.children.each  do |child|
            if child["{\"free\":true,\"mark\":\"nothing\"}"][:node] == nil
                false
            end
        end
        true
    end

    def is_leaf?
        if self.children.size == 0
            true
        else
            false
        end
    end

    def get_UCBI(bias_params)
        (@n_wins / @n_plays) + Math.sqrt(biasParam * Math.log(@parent.n_plays) / @n_plays)
    end


end