# frozen_string_literal: true

module ToyRobot
  class Runner
    attr_reader :robot

    def initialize(tabletop: Tabletop.new)
      @tabletop = tabletop
    end

    def place(east:, north:, facing:)
      return unless @tabletop.valid_position?(east:, north:)

      @robot = Robot.new(east:, north:, facing:)
    end
  end
end
