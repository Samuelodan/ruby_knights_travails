# frozen_string_literal: true

require_relative './square'

# creates boards
class Board
  def initialize
    @squares = build
  end

  def build
    result = []
    (0..7).to_a.repeated_permutation(2) do |perm|
      square = Square.new(perm)
      square.adjacents = add_adj(perm)
      result << square
    end
    result
  end

  def add_adj(coor)
    arr = []
    coor => [x, y]

    arr << [x - 2, y - 1]
    arr << [x + 2, y - 1]
    arr << [x - 2, y + 1]
    arr << [x + 2, y + 1]
    arr << [x - 1, y + 2]
    arr << [x - 1, y - 2]
    arr << [x + 1, y + 2]
    arr << [x + 1, y - 2]

    validate_adj(arr)
  end

  def validate_adj(adj_list)
    adj_list.select do |el|
      el => [x, y]
      x.between?(0, 7) && y.between?(0, 7)
    end
  end

  def look_for(coor)
    @squares.find { |sq| sq.coordinate == coor}
  end

  private
  def reset_sqs
    @squares.each do |sq|
      sq.predecessor = nil
      sq.distance = nil
    end
  end
end
