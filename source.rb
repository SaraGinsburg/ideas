require 'sinatra'
require 'erb'
require 'ostruct'

ideas = [
	{
		:short => "Heading",
		:long_info => "Looooooooooooooooooooooong info"
	},
	{
		:short => "Second Heading",
		:long_info => "Another Looooooooooooooooooooooong info"
	}
]

get '/' do
	@ideas = ideas
  erb :all
end

get '/idea/:id' do
	@idea=ideas[params[:id].to_i]
  erb :idea
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
   redirect to('/')
end
__END__

@@all
<% @ideas.each_index do |index|%>
  	<%= @ideas[index][:short] %> - <%= @ideas[index][:long_info] %>
  	<a href="idea/<%=index%>">Edit</a>
  	<br>
<%end %>

@@idea
<%= @idea[:short] %> - <%= @idea[:long_info] %>

@@new
<form method="post">
 Heading: <input type="text" name="short"><br>
 Information: <input type="text" name="long_info">
 <input type="submit" value="Submit">
</form>