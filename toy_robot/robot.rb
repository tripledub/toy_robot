# frozen_string_literal: true

module ToyRobot
  # The Robot class represents a robot that can move on a grid,
  # turn left or right, and report its current position and direction.
  # It is part of the ToyRobot module.
  class Robot
    # Constants
    # COMPASS defines the cardinal directions the robot can face in clockwise order.
    COMPASS = %w[NORTH EAST SOUTH WEST].freeze

    # Attributes
    # @east [Integer] The robot's current position on the east axis.
    # @north [Integer] The robot's current position on the north axis.
    # @facing [String] The robot's current direction (one of the COMPASS directions).
    attr_reader :east, :facing, :north

    # Initialize the Robot with a starting position and direction.
    #
    # @param east [Integer] The initial position on the east axis (default: 0).
    # @param north [Integer] The initial position on the north axis (default: 0).
    # @param facing [String] The initial direction the robot is facing (default: "NORTH").
    def initialize(east: 0, north: 0, facing: 'NORTH')
      @east = east
      @facing = facing
      @north = north
    end

    # Calculates the next position the robot will move to based on its current position and direction.
    #
    # @return [Hash] A hash with the keys :east and :north.
    # @example
    #   robot.next_position
    #   # => {east: 0, north: 1}
    def next_position
      case facing
      when 'NORTH'
        { east: east, north: north + 1 }
      when 'EAST'
        { east: east + 1, north: north }
      when 'SOUTH'
        { east: east, north: north - 1 }
      when 'WEST'
        { east: east - 1, north: north }
      end
    end

    # Moves the robot one step forward in the current direction.
    # The specific movement is determined by the current facing direction.
    #
    # @return [void, String] Returns a message if the direction is invalid.
    # @example
    #   robot.move
    #   # => nil
    #  robot.facing = "Invalid direction: NORTHWEST"
    def move
      method_name = "move_#{facing.downcase}"
      send(method_name)
    rescue NoMethodError
      "Invalid direction: #{facing}"
    end

    # Turns the robot 90 degrees to the left.
    #
    # @return [void]
    # @example
    #   robot.turn_left
    #   # => nil
    def turn_left
      turn(direction: :left)
    end

    # Turns the robot 90 degrees to the right.
    #
    # @return [void]
    # @example
    #   robot.turn_right
    #   # => nil
    def turn_right
      turn(direction: :right)
    end

    # Reports the robot's current position and direction.
    #
    # @return [Hash] A hash with the keys :east, :north, and :facing.
    # @example
    #   robot.report
    #   # => {east: 0, north: 0, facing: "NORTH"}
    def report
      { east:, north:, facing: }
    end

    private

    # Moves the robot one step forward in the north direction.
    #
    # @return [void]
    def move_east
      @east += 1
    end

    # Moves the robot one step forward in the south direction.
    #
    # @return [void]
    def move_north
      @north += 1
    end

    # Moves the robot one step forward in the west direction.
    #
    # @return [void]
    def move_south
      @north -= 1
    end

    # Moves the robot one step forward in the east direction.
    #
    # @return [void]
    def move_west
      @east -= 1
    end

    # Turns the robot 90 degrees in the specified direction.
    #
    # @param direction [Symbol] The direction to turn the robot (:left or :right).
    # @return [void]
    # @example
    #   robot.turn(direction: :left)
    #   # => nil
    def turn(direction:)
      step = direction == :left ? -1 : 1
      @facing = COMPASS.rotate(step)[COMPASS.index(@facing)]
    end
  end
end
