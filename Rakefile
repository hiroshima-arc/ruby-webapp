require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)
YARD::Rake::YardocTask.new

task :default => :spec

desc 'boot web server'
task :server do
  sh "bin/rackup -o 0.0.0.0 -p $PORT"
end
