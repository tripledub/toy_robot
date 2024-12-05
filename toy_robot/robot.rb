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

    def method_missing(method_name, *args, &block)
      if method_name.to_s.match?(/^turn_(left|right)$/)
        direction = method_name.to_s.split('_').last.to_sym
        step = direction == :left ? -1 : 1
        @facing = COMPASS.rotate(step)[COMPASS.index(@facing)]
      else
        super
      end
    end

    def report
      { east: , north:, facing: }
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
