# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  subject(:robot) { described_class.new(east: 0, north: 0, facing:) }

  describe 'robot behavior with different directions and coordinates' do
    [
      { initial_coords: { east: 0, north: 0 }, facing: 'NORTH', move_result: { east: 0, north: 1 }, left: 'WEST',
        right: 'EAST' },
      { initial_coords: { east: 2, north: 2 }, facing: 'EAST', move_result: { east: 3, north: 2 }, left: 'NORTH',
        right: 'SOUTH' },
      { initial_coords: { east: 4, north: 4 }, facing: 'SOUTH', move_result: { east: 4, north: 3 }, left: 'EAST',
        right: 'WEST' },
      { initial_coords: { east: 3, north: 1 }, facing: 'WEST', move_result: { east: 2, north: 1 }, left: 'SOUTH',
        right: 'NORTH' }
    ].each do |params|
      context "when starting at #{params[:initial_coords]} facing #{params[:facing]}" do
        include_examples 'robot movement and turning',
                         initial_coords: params[:initial_coords],
                         facing: params[:facing],
                         move_result: params[:move_result],
                         left: params[:left],
                         right: params[:right]
      end
    end
  end

  describe 'with an invalid direction' do
    it 'returns a freindly message' do
      robot = described_class.new(east: 0, north: 0, facing: 'NORTHWEST')
      expect(robot.move).to eq('Invalid direction: NORTHWEST')
    end
  end

  describe '#report' do
    let(:facing) { 'NORTH' }

    it 'gives a hash with the current location and position' do
      expect(robot.report).to eq({ east: 0, north: 0, facing: 'NORTH' })
    end
  end

  describe '#next_position' do
    context 'when facing NORTH' do
      let(:facing) { 'NORTH' }

      it 'returns the next position when moving' do
        expect(robot.next_position).to eq({ east: 0, north: 1 })
      end
    end

    context 'when facing EAST' do
      let(:facing) { 'EAST' }

      it 'returns the next position when moving' do
        expect(robot.next_position).to eq({ east: 1, north: 0 })
      end
    end

    context 'when facing SOUTH' do
      let(:facing) { 'SOUTH' }

      it 'returns the next position when moving' do
        expect(robot.next_position).to eq({ east: 0, north: -1 })
      end
    end

    context 'when facing WEST' do
      let(:facing) { 'WEST' }

      it 'returns the next position when moving' do
        expect(robot.next_position).to eq({ east: -1, north: 0 })
      end
    end
  end
end
