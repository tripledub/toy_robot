# frozen_string_literal: true

module ToyRobot
  # The Command module is responsible for parsing textual commands
  # into a structured format that can be processed by the robot "runner"r.
  module Command
    # Parses a given command string and translates it into a standardized array format.
    #
    # Supported commands include:
    # - "PLACE X,Y,FACING" -> [:place, x, y, facing]
    # - "MOVE" -> [:move]
    # - "LEFT" -> [:turn_left]
    # - "RIGHT" -> [:turn_right]
    # - "REPORT" -> [:report]
    #
    # Any unrecognized command returns [:invalid, command].
    #
    # @param command [String] The raw command string to parse.
    # @return [Array] A structured representation of the command:
    #   - [:place, Integer, Integer, String] for PLACE commands.
    #   - [:move], [:turn_left], [:turn_right], [:report] for other valid commands.
    #   - [:invalid, String] for unrecognized commands.
    #
    # @example
    #   Command.parse(command: "PLACE 0,0,NORTH")
    #   # => [:place, 0, 0, "NORTH"]
    #
    # rubocop:disable Metrics/MethodLength
    def self.parse(command:)
      case command
      when /^PLACE\s*(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|EAST|SOUTH|WEST)$/
        [:place, Regexp.last_match(1).to_i, Regexp.last_match(2).to_i, Regexp.last_match(3)]
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
  # rubocop:enable Metrics/MethodLength
end
