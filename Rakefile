require 'bundler'
require 'bundler/gem_tasks'

require 'rake/testtask'

require './test/test_helpers'

Bundler.require(:default, :development)
Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.libs.push "test"
  t.test_files = FileList['test/**/*_test.rb'].unshift('./test/test_helpers.rb')
  t.verbose = true
end
