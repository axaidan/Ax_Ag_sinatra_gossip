$:.unshift File.expand_path("./../lib", __FILE__)
require 'gossip' 

class ApplicationController < Sinatra::Base
	get '/' do
		erb :index, locals: {variable: Gossip.all}
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end

	get '/gossips/:id/' do
		found = Gossip.find(params['id'].to_i)
		erb :show, locals: {variable: [params['id'], found.author, found.content]}
	end

	get '/gossips/:id/edit/' do
		to_edit = Gossip.find(params['id'].to_i)
		erb :edit, locals: {variable: [params['id'], to_edit.author, to_edit.content]}
	end

	post '/gossips/:id/edit/' do
		edit_arr = Gossip.all
		edit_arr[params['id'].to_i] = Gossip.new(params['gossip_author'], params['gossip_content'])
		Gossip.rewrite_db(edit_arr)
		redirect '/'
	end
end
