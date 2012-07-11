require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :openvpn do
  Dir.chdir(File.join(THISDIR, '..', 'modules/openvpn'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'openvpn:test']
