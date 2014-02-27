require 'spec_helper.rb'
require 'byebug'
require 'click2mail'

describe Click2Mail::BatchAPI, "create" do
  it "should return a BatchResponse" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create
    response.class.should eq(BatchResponse)

    response.id.should_not be_nil
    response.has_errors.should eq(false)
    response.received.should eq(false)
    response.submitted.should eq(false)
  end
end

describe Click2Mail::BatchAPI, "create and submit PDF" do
  it "should create a new job and submit the PDF" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_pdf response.id, "assets/test_postcard.pdf"
    upload_response.should be_nil

    status = c2m.status response.id
    status.has_errors.should eq(false)
    status.received.should eq(false)
    status.submitted.should eq(false)
  end
end

__END__
describe Click2Mail::BatchAPI, "create, submit PDF, submit XML" do
  it "should create a new job and submit the PDF and XML" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_pdf response.id, "assets/test_postcard.pdf"
    upload_response.should be_nil



  end
end
