# frozen_string_literal: true

require_relative './square'

# creates boards
class Board
  def initialize
    @squares = []
  end

  def look_for(coor)
    for square in @squares
      return square if square.coordinate == coor
    end
  end
end
