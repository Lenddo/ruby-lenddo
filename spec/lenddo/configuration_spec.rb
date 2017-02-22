require 'spec_helper'

RSpec.describe Lenddo::Configuration do
  subject { Lenddo::Configuration.new }

  it "has instance variable" do
    should respond_to?(:access_key)
    should respond_to?(:secret_key)
  end

  describe "instance variable" do
    let(:access_key) { Lenddo::Configuration.instance_variable_get(:@access_key) }
    let(:secret_key) { Lenddo::Configuration.instance_variable_get(:@secret_key) }

    it "has default value" do
      expect(access_key).to be nil
      expect(secret_key).to be nil
    end
  end
end