require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :puppetdb do
  Dir.chdir(File.join(THISDIR, '..', 'modules/puppetdb'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'puppetdb:test']
