require 'rubygems' 
require 'bundler/setup'

require 'sinatra'
require 'erb'
require 'ostruct'
require 'yaml'

ideas = YAML.load_file('data.yaml')

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
  File.open('data.yaml', 'w') do |out|
    YAML.dump(ideas, out)
  end
  redirect to('/idea/' + params[:id].to_s)
end

get '/delete/:id' do
  ideas.slice!(params[:id].to_i)
  File.open('data.yaml', 'w') do |out|
    YAML.dump(ideas, out)
  end
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
  File.open('data.yaml', 'w') do |out|
    YAML.dump(ideas, out)
  end
  redirect to('/')
end