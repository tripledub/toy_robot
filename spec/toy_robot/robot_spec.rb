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

      describe "turning right" do
        it "faces west" do
          subject.turn_left
          expect(subject.facing).to eq("WEST")
        end
      end

      describe "turning right" do
        it "faces east" do
          subject.turn_right
          expect(subject.facing).to eq("EAST")
        end
      end
    end

    context "when facing south" do
      let(:facing) { "SOUTH" }
      it "moves south" do
        subject.move
        expect(subject.north).to eq(-1)
      end

      describe "turning left" do
        it "faces east" do
          subject.turn_left
          expect(subject.facing).to eq("EAST")
        end
      end

      describe "turning right" do
        it "faces west" do
          subject.turn_right
          expect(subject.facing).to eq("WEST")
        end
      end
    end

    context "when facing east" do
      let(:facing) { "EAST" }
      it "moves east" do
        subject.move
        expect(subject.east).to eq(1)
      end

      describe "turning left" do
        it "faces north" do
          subject.turn_left
          expect(subject.facing).to eq("NORTH")
        end
      end

      describe "turning right" do
        it "faces south" do
          subject.turn_right
          expect(subject.facing).to eq("SOUTH")
        end
      end
    end

    context "when facing west" do
      let(:facing) { "WEST" }
      it "moves west" do
        subject.move
        expect(subject.east).to eq(-1)
      end

      describe "turning left" do
        it "faces south" do
          subject.turn_left
          expect(subject.facing).to eq("SOUTH")
        end
      end

      describe "turning right" do
        it "faces north" do
          subject.turn_right
          expect(subject.facing).to eq("NORTH")
        end
      end
    end

    context "when facing an invalid direction" do
      let(:facing) { "INVALID" }
      it "does not move and returns an error message" do
        result = subject.move
        expect(result).to eq("Invalid direction: INVALID")
        expect(subject.north).to eq(0)
        expect(subject.east).to eq(0)
      end
    end
  end
end
