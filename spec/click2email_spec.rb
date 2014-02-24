require 'spec_helper.rb'
require 'click2mail'

describe Click2Mail::BatchAPI, "create" do
  it "should return a BatchResponse" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create
    response.class.should_eq BatchResponse
  end
end
