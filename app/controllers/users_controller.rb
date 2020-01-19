class UsersController < ApplicationController

  get 'signup' do
    erb :"users/new"
  end

  post '/users' do
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save 
      redirect to '/login'
    else
      erb :"users/new"
    end
  end


  # get '/signup' do
  #   if !logged_in? 
  #     erb :'users/create_user'
  #   else
  #     redirect to '/songs'
  # end


end