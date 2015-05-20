lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'my_data_processors'

# HACK
#   Fix for travis bundle exec rake.
require 'rspec/core/rake_task'
task default: :spec
RSpec::Core::RakeTask.new
# end HACK

desc 'Calculate unique users for a specified file and identifier (eg. facebook.com)'
task :unique_users_per_day, :identifier, :filename do |_, args|
  puts MyDataProcessors::UniqueUsersPerDay.call(args)
end

desc 'Calculate the time spent average per-day on some regex identifier but also visited some identifer'
task :time_spent_average,
     :spent_on, :visit_also, :since, :to, :filename do |_, args|
  puts MyDataProcessors::TimeSpentAverage.call(args)
end

desc 'Calculate the standard deviation of the amount of pageviews'
task :page_views_sd,
     :identifier, :visits_filename, :spread_filename do |_, args|
  puts MyDataProcessors::PageViewsSD.call(args)
end
