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

  describe 'robot actions' do
    before do
      allow(robot_instance).to receive_messages(
        move: nil,
        turn_left: nil,
        turn_right: nil,
        report: { east: 0, north: 0, facing: 'NORTH' },
        next_position: { east: 0, north: 1 }
      )

      runner.place(east: 0, north: 0, facing: 'NORTH')
    end

    describe '#move' do
      it 'delegates the move action to the robot' do
        runner.move
        expect(robot_instance).to have_received(:move)
      end
    end

    describe '#turn_left' do
      it 'delegates the turn_left action to the robot' do
        runner.turn_left
        expect(robot_instance).to have_received(:turn_left)
      end
    end

    describe '#turn_right' do
      it 'delegates the turn_right action to the robot' do
        runner.turn_right
        expect(robot_instance).to have_received(:turn_right)
      end
    end

    describe '#report' do
      it 'delegates the report action to the robot and returns the result' do
        runner.report
        expect(robot_instance).to have_received(:report)
      end

      it 'returns the robot position and facing direction in a readable form' do
        expect { runner.report }.to output("Robot is at (0, 0) facing NORTH\n").to_stdout
      end
    end
  end

  describe 'boundary constraints' do
    before do
      allow(tabletop).to receive(:valid_position?).and_return(true)
      allow(robot_instance).to receive_messages(
        move: nil,
        report: orientation,
        next_position: position
      )

      allow(tabletop).to receive(:valid_position?).and_return(true)
      allow(tabletop).to receive(:valid_position?).with(position).and_return(false)

      runner.place(**orientation)
      runner.move
    end

    context 'when at northern most limit' do
      let(:orientation) { { east: 0, north: 4, facing: 'NORTH' } }
      let(:position) { { east: 0, north: 5 } }

      it 'can not move north' do
        expect(robot_instance).not_to have_received(:move)
      end

      it 'reports the original position' do
        expect do
          runner.report
        end.to output(
          "Robot is at (#{orientation[:east]}, #{orientation[:north]}) facing #{orientation[:facing]}\n"
        ).to_stdout
      end
    end

    context 'when at eastern most limit' do
      let(:orientation) { { east: 4, north: 0, facing: 'EAST' } }
      let(:position) { { east: 5, north: 0 } }

      it 'can not move east' do
        expect(robot_instance).not_to have_received(:move)
      end

      it 'reports the original position' do
        expect do
          runner.report
        end.to output(
          "Robot is at (#{orientation[:east]}, #{orientation[:north]}) facing #{orientation[:facing]}\n"
        ).to_stdout
      end
    end

    context 'when at southern most limit' do
      let(:orientation) { { east: 0, north: 0, facing: 'SOUTH' } }
      let(:position) { { east: 0, north: -1 } }

      it 'can not move south' do
        expect(robot_instance).not_to have_received(:move)
      end

      it 'reports the original position' do
        expect do
          runner.report
        end.to output(
          "Robot is at (#{orientation[:east]}, #{orientation[:north]}) facing #{orientation[:facing]}\n"
        ).to_stdout
      end
    end

    context 'when at western most limit' do
      let(:orientation) { { east: 0, north: 2, facing: 'WEST' } }
      let(:position) { { east: -1, north: 0 } }

      it 'can not move west' do
        expect(robot_instance).not_to have_received(:move)
      end

      it 'reports the original position' do
        expect do
          runner.report
        end.to output(
          "Robot is at (#{orientation[:east]}, #{orientation[:north]}) facing #{orientation[:facing]}\n"
        ).to_stdout
      end
    end
  end
end
