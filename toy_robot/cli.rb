# frozen_string_literal: true

require 'optparse'

require_relative '../toy_robot'

module ToyRobot
  # CLI for the Toy Robot Simulator
  class CLI
    def self.run
      options = parse_options
      dispatcher = ToyRobot::Dispatcher.new

      if options[:file]
        run_file_mode(options[:file], dispatcher)
      else
        run_repl_mode(dispatcher)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def self.parse_options
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: toy_robot_simulator [options]'

        opts.on('-f', '--file FILE', 'Run commands from a file') do |file|
          options[:file] = file
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end.parse!
      options
    end
    # rubocop:enable Metrics/MethodLength

    def self.run_file_mode(file_path, dispatcher)
      commands = dispatcher.read_commands_from_file(file_path: file_path)
      dispatcher.run(commands: commands)
    end

    # rubocop:disable Metrics/MethodLength
    def self.run_repl_mode(dispatcher)
      puts "ToyRobot REPL started. Type commands or 'EXIT' to quit."
      loop do
        print '> '
        input = gets.chomp
        break if input.upcase == 'EXIT'

        command = dispatcher.parser.parse(command: input)
        if command.first == :invalid
          puts "Invalid command: #{command.last}"
        else
          dispatcher.run(commands: [command])
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
