require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :tftp do
  Dir.chdir(File.join(THISDIR, '..', 'modules/tftp'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'tftp:test']
