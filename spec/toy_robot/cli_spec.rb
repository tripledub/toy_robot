require 'spec_helper'
require 'optparse'
require_relative '../../toy_robot/cli'

RSpec.describe ToyRobot::CLI do
  describe '.run' do
    let(:dispatcher) { instance_double(ToyRobot::Dispatcher) }

    before do
      allow(ToyRobot::Dispatcher).to receive(:new).and_return(dispatcher)
    end

    context 'when run with --file option' do
      let(:commands) { [[:place, [0, 0, 'NORTH']], [:move, []]] }

      before do
        allow(dispatcher).to receive(:read_commands_from_file).and_return(commands)
        allow(dispatcher).to receive(:run)
        stub_const('ARGV', ['--file', 'commands.txt'])
      end

      it 'reads commands from file and runs them' do
        expect(dispatcher).to receive(:read_commands_from_file).with(file_path: 'commands.txt')
        described_class.run
      end

      it 'runs commands from the file' do
        expect(dispatcher).to receive(:run).with(commands: commands)
        described_class.run
      end
    end

    context 'when run with --help' do
      before do
        stub_const('ARGV', ['--help'])
      end

      it 'prints help and exits' do
        expect { described_class.run }.to output(/Usage: toy_robot_simulator/).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'when run without arguments (REPL mode)' do
      before do
        stub_const('ARGV', [])
        allow(dispatcher).to receive_message_chain(:parser, :parse).and_return([:move, []])
        allow(dispatcher).to receive(:run)
      end

      #TODO refactor brittle test here
      it 'starts the REPL and accepts commands' do
        allow_any_instance_of(Object).to receive(:gets).and_return("MOVE\n", "EXIT\n")

        expect(dispatcher).to receive(:run).with(commands: [[:move, []]])
        expect { described_class.run }.to output(/ToyRobot REPL started/).to_stdout
      end
    end

    #TODO refactor brittle test here
    context 'when user enters an invalid command in REPL' do
      before do
        stub_const('ARGV', [])
        allow(dispatcher).to receive_message_chain(:parser, :parse)
          .and_return([:invalid, 'bad input'], [:move, []])
        allow(dispatcher).to receive(:run)
      end

      it 'prints an error for invalid command and continues' do
        allow_any_instance_of(Object).to receive(:gets).and_return("INVALID\n", "MOVE\n", "EXIT\n")

        expect { described_class.run }
          .to output(/Invalid command: bad input/).to_stdout
      end
    end
  end
end
