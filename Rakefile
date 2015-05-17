lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'my_data_processors'

desc 'Calculate unique users for a specified file and identifier (eg. facebook.com)'
task :unique_users_per_day, :identifier, :filename do |_, args|
  puts MyDataProcessors::UniqueUsersPerDay.call(args)
end

desc 'Calculate the time spent average per-day'
task :time_spent_average do
end

desc 'Calculate the standard deviation of the amount of pageviews'
task :page_views_standard_deviation do
end
