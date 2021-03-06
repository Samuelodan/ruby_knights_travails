# frozen_string_literal: true

require_relative './square'

# creates boards
class Board
  def initialize
    @squares = build
  end

  def knight_moves(start, stop)
    unless valid_input?(start) && valid_input?(stop)
      puts 'enter valid coordinates'
      return
    end
    result = bfs(start, stop)
    move_count = result.pop
    puts "Nice! You made it in #{move_count} moves \nHere's your path:"
    result.each { |move| p move }
    nil
  end

  private

  def build
    result = []
    (0..7).to_a.repeated_permutation(2) do |perm|
      square = Square.new(perm)
      square.adjacents = add_adj(perm)
      result << square
    end
    result
  end

  def bfs(start, stop)
    reset_sqs
    look_for(start).distance = 0

    queue = [look_for(start)]

    until queue.empty?
      current = queue.shift
      break if current.coordinate == stop

      current.adjacents.each do |adj|
        square = look_for(adj)
        next unless square.distance.nil?

        square.distance = current.distance + 1
        square.predecessor = current
        queue << square
      end
    end
    trace(current)
  end

  def trace(stop)
    arr = []
    move_count = stop.distance
    queue = [stop.coordinate]
    until queue.empty?
      current = look_for(queue.shift)
      current.predecessor && queue << current.predecessor.coordinate
      arr.unshift(current.coordinate)
    end
    arr << move_count
  end

  def add_adj(coor)
    arr = []
    [
      [-2, -1], [+2, -1], [-2, +1], [+2, +1],
      [-1, +2], [-1, -2], [+1, +2], [+1, -2]
    ].each do |move|
      x = coor[0] + move[0]
      y = coor[1] + move[1]
      arr << [x, y]
    end
    validate_adj(arr)
  end

  def validate_adj(adj_list)
    adj_list.select do |el|
      el => [x, y]
      x.between?(0, 7) && y.between?(0, 7)
    end
  end

  def look_for(coor)
    @squares.find { |sq| sq.coordinate == coor }
  end

  def reset_sqs
    @squares.each do |sq|
      sq.predecessor = nil
      sq.distance = nil
    end
  end

  def valid_input?(cood)
    return unless cood.is_a?(Array)

    cood => [x, y]
    x.between?(0, 7) && y.between?(0, 7)
  end
end
