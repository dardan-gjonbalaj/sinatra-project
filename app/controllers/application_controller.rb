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
      !!current_user #!!session[:email]
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

   def login(email,password)
    
    user = User.find_by(:email => email)
    puts user.email
    puts user.password
    puts user.authenticate(password)
    if user && user.authenticate(password)
     # session[:email] = user.id
     puts "made it through the check" 
     #puts current_user.email
    session[:email] = email
    puts session
  else
    redirect '/signup'
   end
  end

   def logout!
     session.clear
   end
end