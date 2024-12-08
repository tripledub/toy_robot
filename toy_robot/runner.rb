# frozen_string_literal: true

module ToyRobot
  # The Runner class acts as a controller for the simulation,
  # managing the robot's placement and interactions with the tabletop.
  class Runner
    # Attributes
    # @robot [Robot, nil] The current robot instance, if one is placed on the tabletop.
    attr_reader :robot, :tabletop

    # Initialize the Runner with a tabletop instance.
    #
    # @param tabletop [Tabletop] The tabletop on which the robot operates (default: a new 5x5 tabletop).
    def initialize(robot: Robot.new, tabletop: Tabletop.new)
      @robot = robot
      @tabletop = tabletop
    end

    # Checks if the robot is currently placed on the tabletop.
    #
    # @return [Boolean] Returns true if the robot is placed, false otherwise.
    # @example
    #   runner.robot_in_place?
    #   # => false
    def robot_in_place?
      robot&.placed?
    end

    # Places the robot on the tabletop at the specified position and facing direction.
    #
    # The robot is only placed if the specified position is valid (i.e., within the tabletop's bounds).
    #
    # @param east [Integer] The east coordinate for the robot's position.
    # @param north [Integer] The north coordinate for the robot's position.
    # @param facing [String] The direction the robot should face (e.g., "NORTH", "EAST").
    # @return [Robot, :invalid_position]
    #     The newly created Robot instance, or ni:invalid_position if the position is invalid.
    # @example
    #   runner.place(east: 0, north: 0, facing: "NORTH")
    #   # => #<ToyRobot::Robot:0x00007f9b1b8b3b10 @east=0, @north=0, @facing="NORTH">
    # @example
    #   runner.place(east: -1, north: 0, facing: "NORTH")
    #   # => :invalid_position
    def place(east:, north:, facing:)
      return :invalid unless tabletop.valid_position?(east:, north:)

      robot.orientation(east: east, north: north, facing: facing)
    end

    # Moves the robot one unit forward in the direction it is currently facing.
    #
    # The robot must be placed on the tabletop before it can move.
    #
    # @return [void]
    def move
      return unless robot_in_place? && tabletop.valid_position?(**robot.next_position)

      robot.move
    end

    # Turns the robot 90 degrees to the left.
    #
    # The robot must be placed on the tabletop before it can turn.
    def turn_left
      return unless robot_in_place?

      robot.turn_left
    end

    # Turns the robot 90 degrees to the right.
    #
    # The robot must be placed on the tabletop before it can turn.
    def turn_right
      return unless robot_in_place?

      robot.turn_right
    end

    # Outputs the robot's current position and facing direction to STDOUT.
    #
    # The robot must be placed on the tabletop before it can report.
    # If the robot is not placed, this method will raise an error or fail silently
    # depending on the implementation of the `robot.report` method.
    #
    # @return [void] This method does not return a value; it only outputs to STDOUT.
    # @example
    #   # When the robot is at position (0, 0) facing NORTH:
    #   runner.report
    #   # Output to STDOUT:
    #   # => "Robot is at (0, 0) facing NORTH"
    def report
      return unless robot_in_place?

      orientation = robot.report
      puts "Robot is at (#{orientation[:east]}, #{orientation[:north]}) facing #{orientation[:facing]}"
    end
  end
end
