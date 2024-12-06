# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Runner do
  let(:tabletop) { ToyRobot::Tabletop.new(width: 5, height: 5) }
  subject { ToyRobot::Runner.new(tabletop:) }

  describe "placing the robot on the tabletop" do
    context "with a valid position" do
      it "is successful" do
        expect(
          ToyRobot::Robot
        ).to receive(:new).with(
          east: 0, north: 0, facing: "NORTH"
        ).and_call_original

        subject.place(east: 0, north: 0, facing: "NORTH")

        expect(subject.robot).to_not be_nil
      end
    end

    context "with an invalid position" do
      it "can not be placed" do
        expect(ToyRobot::Robot).to_not receive(:new)
        subject.place(east: -1, north: 0, facing: "NORTH")
        expect(subject.robot).to be_nil
      end
    end
  end
end
