require 'rspotify'
class SongsController < ApplicationController
  
  get '/songs' do
    if logged_in?
    @songs = Song.all
    erb :'/songs/playlist'
    else
      redirect to 'login'
    end
  end

  get '/songs/new' do
    if logged_in?
      puts current_user.email
      erb :'/songs/add_song'
    else
      redirect '/login'
    end
  end
 

  post '/songs' do
    puts params
    if logged_in?  
      url = get_song_link(params[:title], params[:artist])
      song = current_user.songs.create(title: params[:title] , artist: params[:artist], link: url)
        if song.save
          redirect to "/songs/#{song.id}"
        else
          puts "song already exists...probably ;P"
          redirect to '/songs/new'
        end
      else
        redirect to '/login'
    end
  end

  get '/songs/:id' do
    if logged_in?
      @song = Song.find_by_id(params[:id])
      erb :'/songs/show_song'
    else
      redirect '/songs'
    end
  end

  get '/songs/:id/edit' do
    @song = Song.find_by_id(params[:id])
    erb :'/songs/edit_song'
   
  end

put '/songs/:id' do
  
  if logged_in?
    @song = Song.find_by_id(params[:id])
    binding.pry
    @song.update(title: params[:song][:title])
    redirect to "/songs/#{@song.id}"
  else
    redirect to '/login'
  end
end

  
  delete '/songs/:id/delete' do
    if logged_in?   
      @song = Song.find_by_id(params[:id])
      if @song && @song.user_id == current_user.id
        @song.delete
      end
      redirect to '/songs'
    else
      redirect to '/login'
    end
  end

end
