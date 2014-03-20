require 'spec_helper.rb'
require 'byebug'
require 'click2mail'
require 'stringio'

describe Click2Mail::BatchAPI do
  it "create should return a BatchResponse" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create
    response.class.should eq(Click2Mail::BatchResponse)

    response.id.should_not be_nil
    response.has_errors.should eq(false)
    response.received.should eq(false)
    response.submitted.should eq(false)
  end

  it "should create a new job and submit the PDF" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_pdf response.id, File.open("assets/test_postcard.pdf", "rb")
    upload_response.should eq("SUCCESS")

    status = c2m.status response.id
    status.has_errors.should eq(false)
    status.received.should eq(false)
    status.submitted.should eq(false)
  end

  it "should create a new job and submit broken XML and catch the failure" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_xml response.id, StringIO.new("broken xml document </")
    upload_response.class.should_not eq(Click2Mail::BatchResponse)

    status = c2m.status response.id
    status.has_errors.should eq(true)
  end

  it "should create a new job and submit XML" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_xml response.id, File.open("assets/address-ace.xml")
    upload_response.should eq("SUCCESS")
  end

  it "should create a new job and submit broken XML and catch the failure" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    upload_response = c2m.upload_xml response.id, File.open("assets/address-ace.xml")
    upload_response.should eq("SUCCESS")

    status = c2m.status response.id
    status.has_errors.should eq(false)
    status.received.should eq(false)
    status.submitted.should eq(false)
  end

  it "should do everything (using example XML and PDF files)" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    batch_id = response.id

    upload_response = c2m.upload_xml batch_id, File.open("assets/address-ace.xml")
    upload_response.should eq("SUCCESS")

    upload_response = c2m.upload_pdf batch_id, File.open("assets/test_postcard.pdf", "rb")
    upload_response.should eq("SUCCESS")

    response = c2m.submit batch_id

    status = c2m.status batch_id
    status.has_errors.should eq(false)

    status.received.should eq(true)
    status.submitted.should eq(true)
  end

  it "should do everything, but use Click2Mail::Batch to create the XML" do
    configuration = Click2Mail::Configuration.new
    c2m = Click2Mail::BatchAPI.new(configuration)
    response = c2m.create

    batch_id = response.id


    xml = XmlSimple.xml_out( Click2Mail::Batch.example(configuration).to_hash , "RootName"=>"batch")

    xml_handle = StringIO.new(xml)

    upload_response = c2m.upload_xml batch_id, xml_handle
    upload_response.should eq("SUCCESS")

    upload_response = c2m.upload_pdf batch_id, File.open("assets/test_postcard.pdf", "rb")
    upload_response.should eq("SUCCESS")

    response = c2m.submit batch_id

    status = c2m.status batch_id
    status.has_errors.should eq(false)
    status.received.should eq(true)
    status.submitted.should eq(true)
  end
end
