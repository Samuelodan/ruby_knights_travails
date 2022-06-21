# frozen_string_literal: true

require_relative './square'

# creates boards
class Board
  def initialize
    @squares = []
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

    arr
  end

  def look_for(coor)
    for square in @squares
      return square if square.coordinate == coor
    end
  end
end
