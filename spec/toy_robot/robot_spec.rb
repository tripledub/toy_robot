# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  subject(:robot) { described_class.new(east: 0, north: 0, facing:) }

  describe '#move' do
    context 'when facing a valid direction' do
      directions = {
        'NORTH' => { move_result: { east: 0, north: 1 }, left: 'WEST', right: 'EAST' },
        'SOUTH' => { move_result: { east: 0, north: -1 }, left: 'EAST', right: 'WEST' },
        'EAST' => { move_result: { east: 1, north: 0 }, left: 'NORTH', right: 'SOUTH' },
        'WEST' => { move_result: { east: -1, north: 0 }, left: 'SOUTH', right: 'NORTH' }
      }

      directions.each do |direction, attributes|
        # rubocop:disable RSpec/NestedGroups
        context "when facing #{direction}" do
          let(:facing) { direction }

          it "moves in the #{direction.downcase} direction and updates east" do
            robot.move
            expect(robot.east).to eq(attributes[:move_result][:east])
          end

          it "moves in the #{direction.downcase} direction and updates north" do
            robot.move
            expect(robot.north).to eq(attributes[:move_result][:north])
          end

          it "turns left to face #{attributes[:left]}" do
            robot.turn_left
            expect(robot.facing).to eq(attributes[:left])
          end

          it "turns right to face #{attributes[:right]}" do
            robot.turn_right
            expect(robot.facing).to eq(attributes[:right])
          end
        end
        # rubocop:enable RSpec/NestedGroups
      end
    end

    context 'when facing an invalid direction' do
      let(:facing) { 'NORTHWEST' }

      it 'does not move and returns an error message' do
        result = robot.move
        expect(result).to eq("Invalid direction: #{facing}")
      end

      it 'does not update the east coordinate' do
        robot.move
        expect(robot.east).to eq(0)
      end

      it 'does not update the north coordinate' do
        robot.move
        expect(robot.north).to eq(0)
      end
    end
  end

  describe '#report' do
    let(:facing) { 'NORTH' }

    it 'gives a hash with the current location and position' do
      expect(robot.report).to eq({ east: 0, north: 0, facing: 'NORTH' })
    end
  end
end
