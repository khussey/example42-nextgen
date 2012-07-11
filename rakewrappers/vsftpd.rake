require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :vsftpd do
  Dir.chdir(File.join(THISDIR, '..', 'modules/vsftpd'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'vsftpd:test']
