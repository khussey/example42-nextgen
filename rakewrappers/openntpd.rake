require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :openntpd do
  Dir.chdir(File.join(THISDIR, '..', 'modules/openntpd'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'openntpd:test']
