require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :wordpress do
  Dir.chdir(File.join(THISDIR, '..', 'modules/wordpress'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'wordpress:test']
