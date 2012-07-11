require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :wget do
  Dir.chdir(File.join(THISDIR, '..', 'modules/wget'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'wget:test']
