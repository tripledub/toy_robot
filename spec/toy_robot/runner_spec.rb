# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Runner do
  subject(:runner) { described_class.new(robot: robot_instance, tabletop: tabletop) }

  let(:tabletop) { ToyRobot::Tabletop.new(width: 5, height: 5) }
  let(:robot_instance) { instance_double(ToyRobot::Robot) }

  before do
    allow(robot_instance).to receive_messages(
      orientation: nil,
      move: nil,
      turn_left: nil,
      turn_right: nil,
      report: { east: 0, north: 0, facing: 'NORTH' },
      next_position: { east: 0, north: 1 },
      placed?: false
    )
  end

  describe 'placing the robot on the tabletop' do
    context 'with a valid position' do
      before do
        allow(tabletop).to receive(:valid_position?).with(east: 0, north: 0).and_return(true)
      end

      it 'is successful' do
        runner.place(east: 0, north: 0, facing: 'NORTH')
        expect(robot_instance).to have_received(:orientation).with(
          east: 0, north: 0, facing: 'NORTH'
        )
      end

      it 'sets the robot in place' do
        allow(robot_instance).to receive(:placed?).and_return(true)

        runner.place(east: 0, north: 0, facing: 'NORTH')
        expect(runner.robot_in_place?).to be true
      end
    end

    context 'with an invalid position' do
      before do
        allow(tabletop).to receive(:valid_position?).with(east: -1, north: 0).and_return(false)
      end

      it 'can not be placed' do
        runner.place(east: -1, north: 0, facing: 'NORTH')
        expect(robot_instance).not_to have_received(:orientation)
      end

      it 'does not set the robot in place' do
        runner.place(east: -1, north: 0, facing: 'NORTH')
        expect(runner.robot_in_place?).to be false
      end
    end
  end

  describe 'robot actions' do
    before do
      allow(robot_instance).to receive_messages(
        orientation: nil,
        move: nil,
        turn_left: nil,
        turn_right: nil,
        report: { east: 0, north: 0, facing: 'NORTH' },
        next_position: { east: 0, north: 1 },
        placed?: true
      )

      runner.place(east: 0, north: 0, facing: 'NORTH')
    end

    describe '#move' do
      it 'delegates the move action to the robot when robot is placed' do
        runner.move
        expect(robot_instance).to have_received(:move)
      end

      it 'does not move the robot when it is not placed' do
        allow(robot_instance).to receive(:placed?).and_return(false)
        runner.move
        expect(robot_instance).not_to have_received(:move)
      end
    end

    describe '#turn_left' do
      it 'delegates the turn_left action to the robot when the robot is placed' do
        runner.turn_left
        expect(robot_instance).to have_received(:turn_left)
      end

      it 'does not turn the robot when it is not placed' do
        allow(robot_instance).to receive(:placed?).and_return(false)
        runner.turn_left
        expect(robot_instance).not_to have_received(:turn_left)
      end
    end

    describe '#turn_right' do
      it 'delegates the turn_right action to the robot when the robot is placed' do
        runner.turn_right
        expect(robot_instance).to have_received(:turn_right)
      end

      it 'does not turn the robot when it is not placed' do
        allow(robot_instance).to receive(:placed?).and_return(false)
        runner.turn_right
        expect(robot_instance).not_to have_received(:turn_right)
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

      it 'does not report the robot when it is not placed' do
        allow(robot_instance).to receive(:placed?).and_return(false)
        runner.report
        expect(robot_instance).not_to have_received(:report)
      end
    end
  end

  describe 'boundary constraints' do
    before do
      allow(tabletop).to receive(:valid_position?).and_return(true)
      allow(robot_instance).to receive_messages(
        orientation: nil,
        move: nil,
        report: orientation,
        next_position: position,
        placed?: true
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
