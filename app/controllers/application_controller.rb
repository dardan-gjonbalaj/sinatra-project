require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end
  
  helpers do
    def logged_in?
      !!current_user 
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
  private
  def get_song_link(title,artist)
    #RSpotify.authenticate("CLIENT_ID", "CLIENT_SECRET")  
    tracks = RSpotify::Track.search("#{title} #{artist}")
    return tracks.find {|n| return n.external_urls["spotify"]}
  end

   def login(email,password)
    user = User.find_by(:email => email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      puts session
      true
    else
      puts "Wrong Email or password. Try again"
      redirect '/login'
    end
  end

   def logout!
      puts "Goodbye! #{session[:user_id]}"
      session.destroy
      redirect to '/login'
   end
   
  def redirect_if_not_logged_in
    if !logged_in?  
     redirect to '/login'
    end
  end

end
