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
      allow(runner).to receive(:move)
      allow(runner).to receive(:turn_left)
      allow(runner).to receive(:turn_right)
      allow(runner).to receive(:report)
      dispatcher.run(commands:)
    end

    context 'when PLACE' do
      it 'sends the :place command to the runner' do
        expect(runner).to have_received(:place).with(east: 0, north: 0, facing: 'NORTH')
      end
    end

    context 'when MOVE' do
      let(:commands) { [:move] }

      it 'sends the :move command to the runner' do
        expect(runner).to have_received(:move)
      end
    end

    context 'when LEFT' do
      let(:commands) { [:turn_left] }

      it 'sends the :move command to the runner' do
        expect(runner).to have_received(:turn_left)
      end
    end

    context 'when RIGHT' do
      let(:commands) { [:turn_right] }

      it 'sends the :turn_right command to the runner' do
        expect(runner).to have_received(:turn_right)
      end
    end

    context 'when REPORT' do
      let(:commands) { [:report] }

      it 'sends the :report command to the runner' do
        expect(runner).to have_received(:report)
      end
    end
  end
end
