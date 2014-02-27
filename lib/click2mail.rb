require 'rest-client'
require 'xmlsimple'

def strip_for_require(file_name)
  file_name.gsub(/\.rb$/,'').gsub(/lib\//,'')
end

Dir['lib/click2mail/**/*.rb'].map {|f| strip_for_require(f) }.each do |f|
  require f
end
