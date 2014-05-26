require 'rubygems' 
require 'bundler/setup'

require 'sinatra'
require 'erb'
require 'ostruct'
require 'yaml'

require './database'

ideas_db = Database.new
ideas = ideas_db.read()

get '/' do
	@ideas = ideas
  erb :all
end

get '/idea/:id' do
	@idea=ideas[params[:id].to_i]
  erb :idea
end

get '/edit/:id' do
  @idea=ideas[params[:id].to_i]
  erb :edit
end

post '/edit/:id' do
  ideas[params[:id].to_i][:short] = params[:short]
  ideas[params[:id].to_i][:long_info] = params[:long_info]
  ideas_db.write(ideas)
  redirect to('/idea/' + params[:id].to_s)
end

get '/delete/:id' do
  ideas.slice!(params[:id].to_i)
  ideas_db.write(ideas)
  redirect to('/')
end

get '/new' do
  erb :new
end

post '/new' do
  new_idea = {
    :short => params[:short],
    :long_info => params[:long_info]
  }
  ideas.push(new_idea)
  ideas_db.write(ideas)
  redirect to('/')
end