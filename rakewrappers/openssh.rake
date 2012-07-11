require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :openssh do
  Dir.chdir(File.join(THISDIR, '..', 'modules/openssh'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'openssh:test']
