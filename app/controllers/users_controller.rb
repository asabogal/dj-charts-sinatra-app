class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :"/users/index"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
    erb :"/users/show_user"
    else
      flash[:notice] = "Error: No such user!"
      redirect "/users"
    end
  end

  get '/users/:slug/charts' do
    @user = User.find_by_slug(params[:slug])
    if logged_in?
      if authorized_user?
        erb :"/users/charts"
      else
        redirect "/users/#{@user.slug}"
      end
    else
      flash[:notice] = "Please log in to do that"
      redirect "/login"
    end
  end


  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :"/users/new_user"
    end
  end

  get '/login' do
    if logged_in?
        redirect "/users/#{current_user.slug}"
    else
      erb :"/users/login"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.valid? && !User.find_by(username: params[:username], email: params[:email])
      @user.save
      login!
      redirect "/users/#{@user.slug}"
    elsif @user.valid? && User.find_by(email: params[:email])
      flash[:notice] = "You already have an account. Please log in to access your profile."
      redirect "/login"
    else
      flash[:notice] = "Please fill in all the required fields correctly."
      redirect "/signup"

    end
  end


  post '/login' do
    @user = User.find_by(username: params[:username], email: params[:email])
    if @user && @user.authenticate(params[:password])
      login!
      redirect "/users/#{@user.slug}"
    else
      flash[:notice] = "You don't seem to have an account. Please sign up"
      redirect "/signup"
    end
  end

  get '/logout' do
    if !logged_in?
      flash[:notice] = "You are not logged in. Please login."
      redirect "/login"
    else
      logout!
      flash[:notice] = "You've successfully logged out!"
      redirect "/"
    end
  end


#---
end
