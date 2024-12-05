# frozen_string_literal: true

module ToyRobot
  class Tabletop
    attr_reader :width, :height

    def initialize(width: 5, height: 5)
      @width = width
      @height = height
    end

    def valid_position?(east:, north:)
      east >= 0 && east < width && north >= 0 && north < height
    end
  end
end
