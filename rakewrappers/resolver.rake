require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :resolver do
  Dir.chdir(File.join(THISDIR, '..', 'modules/resolver'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'resolver:test']
