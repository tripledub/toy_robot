# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Tabletop do
  let(:tabletop) { ToyRobot::Tabletop.new(width: 5, height: 5) }

  describe "#initialize" do
    it "creates a new instance of Tabletop" do
      expect(tabletop).to be_an_instance_of ToyRobot::Tabletop
    end

    it "sets the width and height of the tabletop" do
      expect(tabletop.width).to eq 5
      expect(tabletop.height).to eq 5
    end
  end

  describe "#valid_position?" do
    it "returns true if the position is valid" do
      expect(tabletop.valid_position?(east: 0, north: 0)).to eq true
      expect(tabletop.valid_position?(east: 4, north: 4)).to eq true
    end

    it "returns false if the position is invalid" do
      expect(tabletop.valid_position?(east: -1, north: 0)).to eq false
      expect(tabletop.valid_position?(east: -10, north: -1)).to eq false
      expect(tabletop.valid_position?(east: -15, north: 0)).to eq false
      expect(tabletop.valid_position?(east: -10, north: 5)).to eq false
    end
  end
end
