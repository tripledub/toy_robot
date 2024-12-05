# frozen_string_literal: true

module ToyRobot
  class Robot
    attr_reader :coordinates

    def initialize(coordinates: 0)
      @coordinates = coordinates
    end

    def move_east
      @coordinates += 1
    end

    def move_west
      @coordinates -= 1
    end
  end
end
