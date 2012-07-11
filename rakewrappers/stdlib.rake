require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :stdlib do
  Dir.chdir(File.join(THISDIR, '..', 'modules/stdlib'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'stdlib:test']
