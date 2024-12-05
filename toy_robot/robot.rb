# frozen_string_literal: true

module ToyRobot
  class Robot
    attr_reader :east, :facing, :north

    def initialize(east: 0, north: 0, facing: "NORTH")
      @east = east
      @facing = facing
      @north = north
    end

    def move
     case facing
     when "EAST"
       move_east
     when "NORTH"
       move_north
     when "SOUTH"
       move_south
     when "WEST"
       move_west
     end
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
  end
end
