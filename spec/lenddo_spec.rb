require "lenddo"
require "spec_helper"

RSpec.describe Lenddo do
  let(:configuration) { Lenddo.configuration }
  subject { Lenddo.configuration }

  describe "#configuration" do
    it "return existing configuration" do
      [:access_key, :secret_key, :score_service, :network_service].each do |var|
        should respond_to?(var)
      end
    end
  end

  describe "#reset" do
    before :all do
      Lenddo.configure do |config|
        config.access_key = ENV['ACCESS_KEY']
        config.access_key = ENV['SECRET_KEY']
        config.score_service = "https://www.google.com"
        config.network_service = "https://www.facebook.com"
      end
    end

    it "reset the configuration" do
      Lenddo.reset
      expect(configuration.access_key).to be nil
      expect(configuration.secret_key).to be nil
      expect(configuration.score_service).to eq('https://scoreservice.lenddo.com')
      expect(configuration.network_service).to eq('https://networkservice.lenddo.com')
    end
  end

  describe "#configure" do
    before :all do
      Lenddo.configure do |config|
        config.access_key = ENV['ACCESS_KEY']
        config.secret_key = ENV['SECRET_KEY']
        config.score_service = "https://scoreservice.lenddo.com"
        config.network_service = "https://networkservice.lenddo.com"
      end
    end

    it "create new configuration" do
      expect(configuration.access_key).to eq(ENV['ACCESS_KEY'])
      expect(configuration.secret_key).to eq(ENV['SECRET_KEY'])
      expect(configuration.score_service).to eq("https://scoreservice.lenddo.com")
      expect(configuration.network_service).to eq("https://networkservice.lenddo.com")
    end
  end

  describe "#version" do
    it "has a version 1.0.0" do
      ver = Gem::Version.new(Lenddo.version)
      expect(Gem::Requirement.new('1.0.0')).to be_satisfied_by(ver)
    end
  end
end