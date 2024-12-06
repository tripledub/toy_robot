# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'robot movement and turning' do |initial_coords:, facing:, move_result:, left:, right:|
  it "moves in the #{facing.downcase} direction (east)" do
    robot = described_class.new(east: initial_coords[:east], north: initial_coords[:north], facing:)
    robot.move
    expect(robot.east).to eq(move_result[:east])
  end

  it "moves in the #{facing.downcase} direction (north)" do
    robot = described_class.new(east: initial_coords[:east], north: initial_coords[:north], facing:)
    robot.move
    expect(robot.north).to eq(move_result[:north])
  end

  it "turns left to face #{left}" do
    robot = described_class.new(east: initial_coords[:east], north: initial_coords[:north], facing:)
    robot.turn_left
    expect(robot.facing).to eq(left)
  end

  it "turns right to face #{right}" do
    robot = described_class.new(east: initial_coords[:east], north: initial_coords[:north], facing:)
    robot.turn_right
    expect(robot.facing).to eq(right)
  end

  it 'reports its current location and position' do
    robot = described_class.new(east: initial_coords[:east], north: initial_coords[:north], facing:)
    expect(robot.report).to eq({ east: initial_coords[:east], north: initial_coords[:north], facing: facing })
  end
end
