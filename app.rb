require 'rubygems' 
require 'bundler/setup'

require 'sinatra'
require 'erb'
require 'ostruct'
require 'yaml'

require './idea'
require './database'

file = 'data.yaml'

get '/' do
	@ideas = Database.read file
  erb :all
end

get '/idea/:id' do
	@idea = Database.fetch file, params[:id].to_i
  erb :idea
end

get '/edit/:id' do
  @idea = Database.fetch file, params[:id].to_i
  erb :edit
end

post '/edit/:id' do
  Idea.create params
  redirect to('/idea/' + params[:id].to_s)
end

get '/delete/:id' do
  Idea.delete params[:id].to_i
  redirect to('/')
end

get '/new' do
  erb :new
end

post '/new' do
  Idea.create params[:short], params[:long_info]
  redirect to('/')
end