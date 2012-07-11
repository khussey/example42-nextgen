require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

THISDIR = File.dirname(__FILE__)

namespace :postfix do
  Dir.chdir(File.join(THISDIR, '..', 'modules/postfix'))
  load 'Rakefile'
end

task :default => ['ci:setup:rspec', 'postfix:test']
