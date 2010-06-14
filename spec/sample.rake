require "rubygems"

require "spec"
require "spec/rake/spectask"

task :pre do
  "do pre"
end

task :main => :pre do
  "do main"
end

task :main2 => :pre do
  "do main2"
end

task :buggy do
  raise "Wadus"
end

task :call_multi_with_buggy => [:main, :buggy]

namespace :passing_spec do
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = ["spec/spec_pass.rb"]
  end
end

namespace :failing_spec do
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = ["spec/spec_fail.rb"]
  end
end

namespace :wadus do
  task :wadus do
    "do wadus wadus"
  end
end
