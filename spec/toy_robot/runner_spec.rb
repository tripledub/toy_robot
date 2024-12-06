# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Runner do
  subject(:runner) { described_class.new(tabletop:) }

  let(:tabletop) { ToyRobot::Tabletop.new(width: 5, height: 5) }
  let(:robot_instance) { instance_double(ToyRobot::Robot) }

  before do
    allow(ToyRobot::Robot).to receive(:new).and_return(robot_instance)
  end

  describe 'placing the robot on the tabletop' do
    context 'with a valid position' do
      it 'is successful' do
        runner.place(east: 0, north: 0, facing: 'NORTH')
        expect(ToyRobot::Robot).to have_received(:new).with(
          east: 0, north: 0, facing: 'NORTH'
        )
      end

      it 'has a robot' do
        runner.place(east: 0, north: 0, facing: 'NORTH')
        expect(runner.robot).to eq(robot_instance)
      end
    end

    context 'with an invalid position' do
      it 'can not be placed' do
        runner.place(east: -1, north: 0, facing: 'NORTH')
        expect(ToyRobot::Robot).not_to have_received(:new)
      end

      it 'does not have a robot' do
        runner.place(east: -1, north: 0, facing: 'NORTH')
        expect(runner.robot).to be_nil
      end
    end
  end
end
