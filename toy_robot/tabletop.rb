# frozen_string_literal: true

module ToyRobot
  class Tabletop
    attr_reader :width, :height

    def initialize(width: 5, height: 5)
      @width = width
      @height = height
    end

    def valid_position?(east:, north:)
      (0...width).cover?(east) && (0...height).cover?(north)
    end
  end
end
