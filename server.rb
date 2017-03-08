require 'sinatra'
require 'sinatra/reloader'
require 'csv'

set :bind, '0.0.0.0'

configure :development, :test do
  require 'pry'
end

get '/' do
  erb :index
end

get '/articles/new' do
  erb :new_article
end

post '/articles/new' do
  article_details = params.values

  CSV.open('articles.csv', 'a') do |csv|
    csv << article_details
  end

  redirect '/'
end

get '/articles' do
  @article_list = CSV.read('articles.csv')

  erb :articles
end
