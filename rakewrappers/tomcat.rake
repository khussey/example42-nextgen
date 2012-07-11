require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :tomcat do
  Dir.chdir(File.join(THISDIR, '..', 'modules/tomcat'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'tomcat:test']
