require "lenddo"
require "spec_helper"

RSpec.describe Lenddo do
  describe "#version" do
    it "has a version 1.0.0" do
      ver = Gem::Version.new(Lenddo.version)
      expect(Gem::Requirement.new('1.0.1')).to be_satisfied_by(ver)
    end
  end
end