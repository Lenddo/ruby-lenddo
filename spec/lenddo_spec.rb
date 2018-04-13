require "lenddo"
require "spec_helper"

RSpec.describe Lenddo do
  describe "#version" do
    it "has a version 2.1." do
      ver = Gem::Version.new(Lenddo.version)
      expect(Gem::Requirement.new('2.1.0')).to be_satisfied_by(ver)
    end
  end
end
