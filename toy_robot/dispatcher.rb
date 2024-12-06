# frozen_string_literal: true

module ToyRobot
  # Dispatcher class
  class Dispatcher
    attr_reader :runner

    def initialize(runner: ToyRobot::Runner.new)
      @runner = runner
    end

    def read_commands_from_file(file_path:)
      File.readlines(file_path).map do |command|
        ToyRobot::Command.parse(command: command.chomp)
      end
    end

    def run(commands:)
      commands.each do |command, *args|
        case command
        when :place
          runner.place(east: args[0], north: args[1], facing: args[2])
        when :move
          runner.move
        else
          runner.public_send(command, *args)
        end
      end
    end
  end
end
