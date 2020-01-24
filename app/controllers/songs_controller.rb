require 'rspotify'
class SongsController < ApplicationController
  
  get '/songs' do
    redirect_if_not_logged_in
    @songs = current_user.songs
    erb :'/songs/playlist'
    
  end

  get '/songs/new' do
    redirect_if_not_logged_in
    puts current_user.email
    erb :'/songs/add_song'
  end
 

  post '/songs' do
    puts params
    redirect_if_not_logged_in  
      url = get_song_link(params[:title], params[:artist])
      song = current_user.songs.create(title: params[:title] , artist: params[:artist], link: url)
        if song.save
          redirect to "/songs/#{song.id}"
        else
          puts "song already exists...probably ;P"
          redirect to '/songs/new'
        end
      
  end

  get '/songs/:id' do
    redirect_if_not_logged_in
      @song = Song.find_by_id(params[:id])
      erb :'/songs/show_song'
  end

  get '/songs/:id/edit' do
    redirect_if_not_logged_in
    @song = Song.find_by_id(params[:id])
    if current_user.id == @song.user_id
    erb :'/songs/edit_song'
    else
      redirect to '/songs'
    end
  end
 

put '/songs/:id' do
  redirect_if_not_logged_in
  binding.pry
    url = get_song_link(params[:song][:title], params[:song][:artist])
    @song = current_user.songs.find_by_id(params[:id])
    if @song && @song.user_id == current_user.id 
      @song.update(title: params[:song][:title], artist: params[:song][:artist], link: url)
    redirect to "/songs/#{@song.id}"
    else
      redirect to '/songs'
    end
end

  
  delete '/songs/:id/delete' do
    redirect_if_not_logged_in   
      @song = Song.find_by_id(params[:id])
      if @song && @song.user_id == current_user.id
        @song.delete
      end
      redirect to '/songs'
  end

end
