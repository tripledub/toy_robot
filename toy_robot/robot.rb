# frozen_string_literal: true

module ToyRobot
  class Robot
    COMPASS = %w[NORTH EAST SOUTH WEST].freeze

    attr_reader :east, :facing, :north

    def initialize(east: 0, north: 0, facing: "NORTH")
      @east = east
      @facing = facing
      @north = north
    end

    def move
      method_name = "move_#{facing.downcase}"
      send(method_name)
    rescue NoMethodError
      "Invalid direction: #{facing}"
    end

    def turn_left
      turn(direction: :left)
    end

    def turn_right
      turn(direction: :right)
    end

    def report
      {east:, north:, facing:}
    end

    private

    def move_east
      @east += 1
    end

    def move_north
      @north += 1
    end

    def move_south
      @north -= 1
    end

    def move_west
      @east -= 1
    end

    def turn(direction:)
      step = (direction == :left) ? -1 : 1
      @facing = COMPASS.rotate(step)[COMPASS.index(@facing)]
    end
  end
end
