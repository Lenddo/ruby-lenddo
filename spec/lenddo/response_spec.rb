require "spec_helper"

require "lenddo/response"
require "lenddo/errors/exceptions"

class MockResponse
  attr_accessor :status, :response_code, :body
  def initialize(status, body)
    @status = status.to_s
    @response_code = status
    @body = body
  end
end

RSpec.describe Lenddo::Response do
  it "should not raise an UnknownError when json is valid" do
    mock_response = MockResponse.new(200, '{"hello": 1}')
    Lenddo::Response.new mock_response
  end

  it "should raise an UnknownError when something fails" do
    mock_response = MockResponse.new(200, "<html></html>")
    expect{Lenddo::Response.new mock_response}.to raise_error(Lenddo::Errors::UnknownException)
  end

  it "should raise Lenddo::Errors::InternalErrorException on HTTP 500" do
    mock_response = MockResponse.new(500, "Inter Error")
    expect {
      Lenddo::Response.new mock_response
    }.to raise_error(Lenddo::Errors::InternalErrorException)
  end

  it "should raise Lenddo::Errors::UnknownException on > HTTP 500" do
    mock_response = MockResponse.new(502, "Bad Gateway")
    expect {
      Lenddo::Response.new mock_response
    }.to raise_error(Lenddo::Errors::UnknownException)
  end
end
