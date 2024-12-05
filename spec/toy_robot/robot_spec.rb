# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Robot do
  describe "moving in direction robot facing" do
    let(:facing) { "NORTH" }

    subject { ToyRobot::Robot.new(east: 0, north: 0, facing:) }

    context "when facing north" do
      it "moves north" do
        subject.move
        expect(subject.north).to eq(1)
      end
    end

    context "when facing south" do
      let(:facing) { "SOUTH" }
      it "moves south" do
        subject.move
        expect(subject.north).to eq(-1)
      end
    end

    context "when facing east" do
      let(:facing) { "EAST" }
      it "moves east" do
        subject.move
        expect(subject.east).to eq(1)
      end
    end

    context "when facing west" do
      let(:facing) { "WEST" }
      it "moves west" do
        subject.move
        expect(subject.east).to eq(-1)
      end
    end
  end
end
