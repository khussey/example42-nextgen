require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :haproxy do
  Dir.chdir(File.join(THISDIR, '..', 'modules/haproxy'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'haproxy:test']
