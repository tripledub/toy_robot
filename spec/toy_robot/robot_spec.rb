# frozen_string_literal: true

require "spec_helper"

RSpec.describe ToyRobot::Robot do
  subject { ToyRobot::Robot.new(coordinates: 0) }

  describe "has a coordinates attribute that can be incremented by a :move command" do
    context "when called once" do
      it "moves 1 unit/space" do
        subject.move
        expect(subject.coordinates).to eq(1)
      end
    end

    context "when called 3 times" do
      it "moves 3 unit/spaces" do
        3.times { subject.move }
        expect(subject.coordinates).to eq(3)
      end
    end
  end
end
