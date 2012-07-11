require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :redis do
  Dir.chdir(File.join(THISDIR, '..', 'modules/redis'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'redis:test']
