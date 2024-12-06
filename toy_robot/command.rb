# frozen_string_literal: true

module ToyRobot
  class Command
    def self.parse(command:)
      result = command.match(/^([A-Z]+)\s+(\d+),(\d+),([A-Z]+)$/)

      return [:invalid, command] unless result

      action = result.captures
      [action[0].downcase.to_sym, action[1].to_i, action[2].to_i, action[3]]
    end
  end
end
