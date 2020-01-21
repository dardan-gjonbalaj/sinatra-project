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

  def get_song_link(title,artist)
    RSpotify.authenticate("6a6690d21a154c1fb88cb4e3ad13caf0", "335e78b7943446c597691ccbe733924a")  
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
   
end
