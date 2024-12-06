# frozen_string_literal: true

module ToyRobot
  # The Runner class acts as a controller for the simulation,
  # managing the robot's placement and interactions with the tabletop.
  class Runner
    # Attributes
    # @robot [Robot, nil] The current robot instance, if one is placed on the tabletop.
    attr_reader :robot

    # Initialize the Runner with a tabletop instance.
    #
    # @param tabletop [Tabletop] The tabletop on which the robot operates (default: a new 5x5 tabletop).
    def initialize(tabletop: Tabletop.new)
      @tabletop = tabletop
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
      return :invalid unless @tabletop.valid_position?(east:, north:)

      # IMHO direct instantiation of the Robot class is not a good practice
      # because it makes the Runner class tightly coupled to the Robot class.
      # Instead, I would suggest using a factory method or dependency injection
      # to create the robot instance. This would make the code more flexible
      # and easier to test. However, for the purposes of meeting the requirements
      # of the exercise, I will leave the code as is.
      @robot = Robot.new(east:, north:, facing:)
    end
  end
end
