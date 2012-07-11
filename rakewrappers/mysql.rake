require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :mysql do
  Dir.chdir(File.join(THISDIR, '..', 'modules/mysql'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'mysql:test']
