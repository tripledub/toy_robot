# frozen_string_literal: true

module ToyRobot
  # The Dispatcher class is responsible for coordinating commands between a
  # command parser and a runner that controls the robot simulation. It acts as
  # an intermediary, reading commands from a source (e.g., a file) and executing
  # them via the runner.
  class Dispatcher
    # Attributes
    # @parser [ToyRobot::Command] The command parser used to interpret textual commands.
    # @runner [ToyRobot::Runner] The runner that controls the robot simulation.
    attr_reader :parser, :runner

    # Initialize the Dispatcher with a command parser and runner.
    #
    # @param parser [ToyRobot::Command] The command parser used to interpret textual commands.
    # @param runner [ToyRobot::Runner] The runner that controls the robot simulation.
    def initialize(parser: ToyRobot::Command, runner: ToyRobot::Runner.new)
      @parser = parser
      @runner = runner
    end

    # Reads commands from a file and parses them into a structured format.
    #
    # @param file_path [String] The path to the file containing the commands.
    # @return [Array] An array of structured commands.
    # @example
    #   dispatcher.read_commands_from_file(file_path: 'commands.txt')
    #   # => [[:place, 0, 0, 'NORTH'], [:move], [:turn_left], [:turn_right], [:report]]
    def read_commands_from_file(file_path:)
      File.readlines(file_path).map do |command|
        parser.parse(command: command.chomp)
      end
    end

    # Executes a series of commands on the runner.
    #
    # @param commands [Array] An array of structured commands to execute.
    # @return [void]
    # @example
    #   dispatcher.run(commands: [[:place, 0, 0, 'NORTH'], [:move], [:turn_left]])
    #   # => nil
    def run(commands:)
      commands.each do |command, *args|
        case command
        when :place
          runner.place(east: args[0], north: args[1], facing: args[2])
        when :invalid
          puts "Invalid command: #{args[0]}"
        else
          runner.public_send(command, *args)
        end
      end
    end
  end
end
