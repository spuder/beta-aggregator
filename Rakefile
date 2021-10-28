require 'rake'
require 'rake/testtask'

# require_relative 'lib/tasks/exercise_test_tasks'

task default: %i[test]

# desc 'Run individual exercises or run all development and exercise tests'
# task :test do
#   Rake::Task['test:dev'].invoke
#   Rake::Task['test:exercises'].invoke
# end

desc 'Run Rubocop'
task :rubocop do
  system('rubocop --display-cop-names')
end

namespace 'scrape' do
  desc 'Run scrape road trip ryan'
  task :roadtripryan do
    ruby "scrapers/roadtripryan.rb"
  end

  desc 'Run scrape canyoneering usa'
  task :canyoneeringusa do
    ruby "scrapers/canyoneeringusa.rb"
  end

end


desc 'Run tests'
task :test do
    ruby "test/*_test.rb"
end

# namespace :test do
#   flags = ARGV.drop_while { |e| e != '--' }.drop(1).join(' ')

#   desc 'Run all development tests located in the test directory'
#   Rake::TestTask.new :dev do |task|
#     task.options = flags
#     task.pattern = 'test/**/*_test.rb'
#   end

#   ExerciseTestTasks.new options: flags
# end