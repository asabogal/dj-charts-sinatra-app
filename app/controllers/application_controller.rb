require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :session
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

    def logged_in?
      !!session[:user_id]
    end

    def current_user
     User.find(session[:user_id])
   end

  end

end
