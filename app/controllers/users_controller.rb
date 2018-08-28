class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show_user"
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}" #? or id?
    else
      erb :"/users/new_user"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      redirect "/signup"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.valid? && !User.find_by(email: params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    elsif User.find_by(email: params[:email])
      #flash message you already have an account. Please login:
      redirect "/login"
    else
      #do Flash Message: please try again!
      redirect "/signup"
    end
  end

  # post login : @user.authenticate(params[:password])



#---
end
