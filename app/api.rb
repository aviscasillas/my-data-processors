require 'sinatra'
require 'my_data_processors'

get '/unique_users' do
  MyDataProcessors::UniqueUsersPerDay.call(params).tap do
    status 200
  end
end

get '/time_spent_average' do
  MyDataProcessors::TimeSpentAverage.call(params).tap do
    status 200
  end
end

get '/page_views_sd' do
  MyDataProcessors::PageViewsSD.call(params).tap do
    status 200
  end
end

run Sinatra::Application.run!
