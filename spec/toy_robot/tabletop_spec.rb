# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Tabletop do
  let(:tabletop) { described_class.new(width: 5, height: 5) }

  describe '#initialize' do
    it 'sets the width of the table top to 5' do
      expect(tabletop.width).to eq 5
    end

    it 'sets the height of the tabletop to 5' do
      expect(tabletop.height).to eq 5
    end
  end

  describe '#valid_position?' do
    let(:valid_positions) do
      [
        { east: 0, north: 0 },
        { east: 4, north: 4 }
      ]
    end

    let(:invalid_positions) do
      [
        { east: -1, north: 0 },
        { east: 5, north: 0 },
        { east: 0, north: -1 },
        { east: 0, north: 5 }
      ]
    end

    it 'returns true if the position is valid' do
      valid_positions.each do |position|
        expect(tabletop.valid_position?(east: position[:east], north: position[:north])).to be(true)
      end
    end

    it 'returns false if the position is invalid' do
      invalid_positions.each do |position|
        expect(tabletop.valid_position?(east: position[:east], north: position[:north])).to be(false)
      end
    end
  end
end
