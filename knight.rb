class Board
  def build_grid(array)
    grid = Array.new(8) { Array.new(8, "O")}

    array.each do |step|
      grid[step[0]][step[1]] = "X"
    end

    i = 0
    puts "    ---------------"

    grid.each do |row|
      puts "#{i} | #{row.join(" ")} |"
      i += 1
    end

    puts "    ---------------"
    puts "    0 1 2 3 4 5 6 7"

  end
end

class Square
  attr_reader :space, :last

  def initialize(space, last = nil)
    @space = space
    @last = last
  end

end

class Knight

  def initialize()
    @visited = []
  end
  
  def knight_moves(start, finish)
    # edge case: start and finish are the same
    return [start] if start == finish

    # root node representing the first space in the path, "last" node is nil
    # starting space is counted as visited, so it can't be used again

    first_node = Square.new(start)
    queue = [first_node]

    until queue.first.space == finish
      current_node = queue.first
      @visited.push(current_node.space)
      moveset = get_moveset(current_node.space)
      moveset.each do |move|
        queue.push(Square.new(move, current_node)) unless repeat?(move) 
      end
      queue.shift
    end

    path = []
    last_node = queue.first

    until last_node.nil?
      path.unshift(last_node.space)
      last_node = last_node.last
    end

    puts "You made it in #{path.length} moves! Here's your path:"
    path.each { |move| puts "#{move}\n"}
    return path
  end

  def get_moveset(start)
    moveset = []
    i = 1
    8.times do
      case i
      when 1
        move = [start[0] + 2, start[1] + 1] # move 1, up 2 -> right 1
      when 2
        move = [start[0] + 1, start[1] + 2] # move 2, up 1 -> right 2
      when 3
        move = [start[0] + 2, start[1] - 1] # move 3, up 2 -> left 1
      when 4
        move = [start[0] + 1, start[1] - 2] # move 4, up 1 -> left 2
      when 5
        move = [start[0] - 2, start[1] + 1] # move 5, down 2 -> right 1
      when 6
        move = [start[0] - 1, start[1] + 2] # move 6, down 1 -> right 2
      when 7
        move = [start[0] - 2, start[1] - 1] # move 7, down 2 -> left 1
      when 8
        move = [start[0] - 1, start[1] - 2] # move 8, down 1 -> left 2
      end

      i += 1

      unless move[0] > 7 || move[0] < 0 || move[1] > 7 ||
      move[1] < 0 || repeat?(move)
        moveset.push(move)
      end

    end

    return moveset
  end

  def repeat?(move)
    @visited.each do |slot|
      if slot[0] == move[0] && slot[1] == move[1]
        return true
      end
    end
    return false
  end

end

chessboard = Board.new()
horse = Knight.new()
chessboard.build_grid(horse.knight_moves([0,0],[7,6]))