require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :munin do
  Dir.chdir(File.join(THISDIR, '..', 'modules/munin'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'munin:test']
