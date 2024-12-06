# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Command do
  context "PLACE" do
    it "can read in the PLACE command" do
      command, *args = ToyRobot::Command.parse(command: "PLACE 0,0,NORTH")
      expect(command).to eq(:place)
      expect(args).to eq [0, 0, "NORTH"]
    end

    it "returns :invalid if the PLACE command is invalid" do
      invalid_input = "PLaCe 0, 0,  NORTH"
      command = ToyRobot::Command.parse(command: invalid_input)
      expect(command).to eq([:invalid, invalid_input])
    end
  end

  context "MOVE" do
    it "can read in the MOVE command" do
      command, *args = ToyRobot::Command.parse(command: "MOVE")
      expect(command).to eq(:move)
      expect(args).to be_empty
    end
  end

  context "LEFT" do
    it "can read in the LEFT command" do
      command, *args = ToyRobot::Command.parse(command: "LEFT")
      expect(command).to eq(:turn_left)
      expect(args).to be_empty
    end
  end

  context "RIGHT" do
    it "can read in the RIGHT command" do
      command, *args = ToyRobot::Command.parse(command: "RIGHT")
      expect(command).to eq(:turn_right)
      expect(args).to be_empty
    end
  end

  context "REPORT" do
    it "can read in the REPORT command" do
      command, *args = ToyRobot::Command.parse(command: "REPORT")
      expect(command).to eq(:report)
      expect(args).to be_empty
    end
  end
end
