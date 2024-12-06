# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Dispatcher do
  subject(:dispatcher) { described_class.new }

  describe 'load commands' do
    let(:file_path) { 'spec/fixtures/commands.txt' }
    let(:expected_commands) do
      [
        [:place, 0, 0, 'NORTH'],
        [:move],
        [:turn_left],
        [:turn_right],
        [:report]
      ]
    end

    it 'reads commands from file' do
      expect(
        dispatcher.read_commands_from_file(file_path:)
      ).to eq(expected_commands)
    end
  end

  describe 'run' do
    let(:runner) { instance_double(ToyRobot::Runner) }
    let(:commands) { [[:place, 0, 0, 'NORTH']] }

    before do
      allow(ToyRobot::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:place)
    end

    it 'runs commands' do
      dispatcher.run(commands:)
      expect(runner).to have_received(:place).with(east: 0, north: 0, facing: 'NORTH')
    end
  end
end
