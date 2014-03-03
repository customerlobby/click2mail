require "bundler/gem_tasks"
require "click2mail"

desc "load the environment then debug"
task :debugger do
  require 'byebug'
  byebug
end

desc ""
task :batch_status, :batch_id do |t, args|
  batch_id = args[:batch_id]

  configuration = Click2Mail::Configuration.new
  c2m = Click2Mail::BatchAPI.new(configuration)

  status = c2m.status batch_id
  puts status.inspect
end
