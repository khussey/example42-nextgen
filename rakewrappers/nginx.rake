require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :nginx do
  Dir.chdir(File.join(THISDIR, '..', 'modules/nginx'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'nginx:test']
