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
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save 
      redirect to '/login'
    else
      erb :'/songs'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    puts session[:email]
    puts params
      if login(params[:email],params[:password])
        redirect to '/songs'
    else
      "I GOT HERE NOW"
      logout!
      
    end
  end


  # get '/signup' do
  #   if !logged_in? 
  #     erb :'users/create_user'
  #   else
  #     redirect to '/songs'
  # end


end