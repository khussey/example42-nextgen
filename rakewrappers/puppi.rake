require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :puppi do
  Dir.chdir(File.join(THISDIR, '..', 'modules/puppi'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'puppi:test']
