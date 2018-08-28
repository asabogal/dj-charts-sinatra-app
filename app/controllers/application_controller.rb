require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "recordcharts"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if logged_in?
      redirect "/charts/index"
    else
      erb :welcome
    end
  end

  helpers do

    def login!
      session[:user_id] = User.self.id
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

  end

end
