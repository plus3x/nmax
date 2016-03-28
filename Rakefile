require 'bundler'
require 'rake/testtask'

Rake::TestTask.new :default do |test|
  test.pattern = 'test/**/*_test.rb'
end

desc 'Have Bundler setup a standalone environment -- run tests in this, b/c its faster and safer'
task :build do
  # Running without rubygems  # http://myronmars.to/n/dev-blog/2012/03/faster-test-boot-times-with-bundler-standalone
  sh 'bundle install --standalone --binstubs bundle/bin'
end

file :bundle do
  $stderr.puts "\e[31mLooks like the gems aren\'t installed, run `rake build` to install them\e[39m"
  exit 1
end

desc 'Run tests'
task test: :bundle do
  sh 'ruby', '--disable-gem', *Dir["#{Bundler.root}/test/**/*_test.rb"].flat_map { |p| ['-I', p] }, '-S', 'bundle/bin/rake'
end

desc 'Install dependencies and run tests (mainly for Travis CI)'
task ci: %i(build test)
