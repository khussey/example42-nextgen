require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :xinetd do
  Dir.chdir(File.join(THISDIR, '..', 'modules/xinetd'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'xinetd:test']
