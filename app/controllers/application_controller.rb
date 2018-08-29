require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    enable :sessions
    set :session_secret, "recordcharts"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if logged_in?
      redirect "/charts"
    else
      erb :welcome
    end
  end

  helpers do

    def login!
      session[:user_id] = @user.id
    end

    def logout!
      session.clear
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
     User.find(session[:user_id])
   end

    def authorized_user?
      @user == current_user
    end

  end

end
