# frozen_string_literal: true

require_relative "toy_robot/command"
require_relative "toy_robot/robot"
require_relative "toy_robot/runner"
require_relative "toy_robot/tabletop"

module ToyRobot
  class Command
    def self.parse(command:)
      result = command.match(/^([A-Z]+)\s+(\d+),(\d+),([A-Z]+)$/).captures
      [result[0].downcase.to_sym, result[1].to_i, result[2].to_i, result[3]]
    end
  end
end
