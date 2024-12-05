# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Robot do
  subject { ToyRobot::Robot.new(east: 0) }

  describe "moving the robot 'eastward/right'" do
    context "when called once" do
      it "moves 1 unit/space east" do
        subject.move_east
        expect(subject.east).to eq(1)
      end
    end

    context "when called 3 times" do
      it "moves 3 unit/spaces east" do
        3.times { subject.move_east }
        expect(subject.east).to eq(3)
      end
    end
  end

  describe "moving the robot 'westward/left'" do
    context "when called once" do
      it "moves 1 unit/space west" do
        subject.move_west
        expect(subject.east).to eq(-1)
      end
    end

    context "when called 3 times" do
      it "moves 3 unit/spaces west" do
        3.times { subject.move_west }
        expect(subject.east).to eq(-3)
      end
    end
  end

  describe "moving the robot 'northward/up'" do
    context "when called once" do
      it "moves 1 unit/space north" do
        subject.move_north
        expect(subject.north).to eq(1)
      end
    end

    context "when called 3 times" do
      it "moves 3 unit/spaces north" do
        3.times { subject.move_north }
        expect(subject.north).to eq(3)
      end
    end
  end

  describe "moving the robot 'southward/up'" do
    context "when called once" do
      it "moves 1 unit/space south" do
        subject.move_south
        expect(subject.north).to eq(-1)
      end
    end

    context "when called 3 times" do
      it "moves 3 unit/spaces south" do
        3.times { subject.move_south }
        expect(subject.north).to eq(-3)
      end
    end
  end

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
