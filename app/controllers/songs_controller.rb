class SongsController < ApplicationController
  get '/songs' do
    puts params
    "The songs will be here"
  end

  get '/songs/new' do
    #if !logged_in?
      #redirect "/login"
    #else
      "Your songs?"
      puts params
    #end
  end

  get '/songs/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      if song = current_user.songs.find_by(params[:id])
      "#{current_user.id} is looking at #{song.id}"
      else
        redirect "/songs"
      end
    end
    end
end