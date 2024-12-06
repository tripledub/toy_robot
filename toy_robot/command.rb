# frozen_string_literal: true

module ToyRobot
  class Command
    def self.parse(command:)
      case command
      when /^PLACE\s+(\d+),(\d+),([A-Z]+)$/
        [:place, $1.to_i, $2.to_i, $3]
      when /^MOVE$/
        [:move]
      when /^LEFT$/
        [:turn_left]
      when /^RIGHT$/
        [:turn_right]
      when /^REPORT$/
        [:report]
      else
        [:invalid, command]
      end
    end
  end
end
