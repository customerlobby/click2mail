require "bundler/gem_tasks"
require "click2mail"

desc "load the environment then debug"
task :debugger do
  require 'byebug'
  byebug
end

desc "Find the batch status given a batch_id"
task :batch_status, :batch_id do |t, args|
  batch_id = args[:batch_id]

  configuration = Click2Mail::Configuration.new
  c2m = Click2Mail::BatchAPI.new(configuration)

  status = c2m.status batch_id
  puts status.to_yaml
end

desc "Request tracking information for a specific jobId"
task :request_tracking, :job_id do |t, args|
  job_id = args[:job_id]

  configuration = Click2Mail::Configuration.new
  molpro = Click2Mail::MolPro.new(configuration)

  tracking_results = molpro.request_tracking(job_id)

  puts tracking_results.to_yaml
end

desc "Run Test upload"
task :test do

  configuration = Click2Mail::Configuration.new
  puts configuration.inspect

  c2m = Click2Mail::BatchAPI.new(configuration)
  response = c2m.create

  batch_id = response.id

  xml = XmlSimple.xml_out( Click2Mail::Batch.example(configuration).to_hash , "RootName"=>"batch")

  xml_handle = StringIO.new(xml)

  upload_response = c2m.upload_xml batch_id, xml_handle

  upload_response = c2m.upload_pdf batch_id, File.open("assets/test_postcard.pdf", "rb")

  response = c2m.submit batch_id
  puts response.inspect

  status = c2m.status batch_id
  puts status.inspect
end
