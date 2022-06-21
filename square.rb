# frozen_string_literal: true

# creates squares for board
class Square
  attr_accessor :distance, :predecessor, :adjacents
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    @adjacents = []
    @distance = nil
    @predecessor = nil
  end
end
