require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :libvirt do
  Dir.chdir(File.join(THISDIR, '..', 'modules/libvirt'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'libvirt:test']
