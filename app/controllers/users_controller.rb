class UsersController < ApplicationController
  get '/users' do
    puts current_user
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/songs'
    end
  end


  post '/signup' do
   # binding.pry
    if !(params[:email].strip =~ URI::MailTo::EMAIL_REGEXP).nil? && (params[:password] =~ /\S/).equal?(0)
      @user = User.new(name: params[:name].strip, email: params[:email].strip, password: params[:password].strip)
      if @user.save 
        redirect to '/login'
      else
        puts "Email already exists"
        redirect to '/signup'
      end
    else
      puts "Invalid email or password (no spaces please)"
      redirect to '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    puts session[:user_id]
    puts params
      if login(params[:email],params[:password])
        redirect to '/songs'
    else
      puts "Invalid Credentials"
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout!
    else
      puts "You're not logged in!"
      redirect to '/login'
    end
  end
end

