require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :maven do
  Dir.chdir(File.join(THISDIR, '..', 'modules/maven'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'maven:test']
