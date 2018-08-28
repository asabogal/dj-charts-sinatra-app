class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show_user"
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.id}"
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
    if @user.valid? && !User.find_by(email: params[:email])
      @user.save
      login!
      redirect "/users/#{@user.slug}"
    elsif User.find_by(email: params[:email])
      #flash message you already have an account. Please login:
      redirect "/login"
    else
      #do Flash Message: please try again!
      redirect "/signup"
    end
  end


  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      login!
      redirect "/users/#{@user.slug}"

    else
      #flash message: you don't seem to have an account. Please sign up
      redirect "/signup"
    end
  end

    get '/logout' do
      logout!
      redirect "/login"
    end


#---
end
