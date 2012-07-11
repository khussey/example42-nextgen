require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :apache do
  Dir.chdir(File.join(THISDIR, '..', 'modules/apache'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'apache:test']
