require 'bundler'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'active_support/hash_with_indifferent_access'
Bundler.require(:default, :development)
Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
