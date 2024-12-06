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
end
