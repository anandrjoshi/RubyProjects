require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'

task :default => [:test_units, :rcov]

Rake::TestTask.new('test_units') do |t|
  t.libs << ['src', 'test']
  t.pattern = 'test/grading*.rb'
  t.verbose = true
  t.warning = true
end

Rcov::RcovTask.new("rcov") do |test|
  test.libs << ['src', 'test']
  test.pattern = 'test/grading*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "spec/*,gems/*" '
end

task :run do
	ruby 'src/game.rb'
end
