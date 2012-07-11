require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :foo do
  Dir.chdir(File.join(THISDIR, '..', 'modules/foo'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'foo:test']
