# frozen_string_literal: true

require_relative "toy_robot/command"
require_relative "toy_robot/robot"
require_relative "toy_robot/runner"
require_relative "toy_robot/tabletop"

module ToyRobot
  class Command
    def self.input(command:)
      [:place, 0,0, "NORTH"]
    end
  end
end
