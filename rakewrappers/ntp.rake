require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :ntp do
  Dir.chdir(File.join(THISDIR, '..', 'modules/ntp'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'ntp:test']
