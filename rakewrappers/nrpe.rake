require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :nrpe do
  Dir.chdir(File.join(THISDIR, '..', 'modules/nrpe'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'nrpe:test']
