# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Command do
  context 'when PLACE' do
    it 'can extract in the PLACE command' do
      command, = described_class.parse(command: 'PLACE 0,0,NORTH')
      expect(command).to eq(:place)
    end

    it 'can extract the other *args from the PLACE command' do
      _, *args = described_class.parse(command: 'PLACE 0,0,NORTH')
      expect(args).to eq [0, 0, 'NORTH']
    end
  end

  describe 'simple commands' do
    context 'when MOVE' do
      it 'can read in the MOVE command' do
        command, = described_class.parse(command: 'MOVE')
        expect(command).to eq(:move)
      end

      it 'has no *args' do
        _, *args = described_class.parse(command: 'MOVE')
        expect(args).to be_empty
      end
    end

    context 'when LEFT' do
      it 'can read in the LEFT command' do
        command, = described_class.parse(command: 'LEFT')
        expect(command).to eq(:turn_left)
      end

      it 'has no *args' do
        _, *args = described_class.parse(command: 'LEFT')
        expect(args).to be_empty
      end
    end

    context 'when RIGHT' do
      it 'can read in the RIGHT command' do
        command, = described_class.parse(command: 'RIGHT')
        expect(command).to eq(:turn_right)
      end

      it 'has no *args' do
        _, *args = described_class.parse(command: 'RIGHT')
        expect(args).to be_empty
      end
    end

    context 'when REPORT' do
      it 'can read in the REPORT command' do
        command, = described_class.parse(command: 'REPORT')
        expect(command).to eq(:report)
      end

      it 'has no *args' do
        _, *args = described_class.parse(command: 'REPORT')
        expect(args).to be_empty
      end
    end
  end

  context 'when invalid' do
    let(:input) { 'OOPS, 1,1, NORTHWARD' }

    it 'can read in the invalid command' do
      command, = described_class.parse(command: input)
      expect(command).to eq(:invalid)
    end

    it 'can extract the invalid command' do
      _, *args = described_class.parse(command: input)
      expect(args).to eq [input]
    end
  end
end
