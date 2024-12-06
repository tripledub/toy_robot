# frozen_string_literal: true

module ToyRobot
  # The Tabletop class represents a rectangular surface on which the robot can move.
  # It defines the boundaries for valid positions and ensures the robot stays within these limits.
  class Tabletop
    # Attributes
    # @width [Integer] The width of the tabletop (number of units along the east axis).
    # @height [Integer] The height of the tabletop (number of units along the north axis).
    attr_reader :width, :height

    # Initialize the Tabletop with a given width and height.
    #
    # @param width [Integer] The width of the tabletop (default: 5).
    # @param height [Integer] The height of the tabletop (default: 5).
    def initialize(width: 5, height: 5)
      @width = width
      @height = height
    end

    # Check if a given position is within the boundaries of the tabletop.
    #
    # @param east [Integer] The position on the east axis.
    # @param north [Integer] The position on the north axis.
    # @return [Boolean] Returns true if the position is valid, false otherwise.
    # @example
    #   tabletop.valid_position?(east: 0, north: 0)
    #   # => true
    def valid_position?(east:, north:)
      (0...width).cover?(east) && (0...height).cover?(north)
    end
  end
end
