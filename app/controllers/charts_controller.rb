class ChartsController < ApplicationController

  get '/charts' do
    erb :"/charts/index"
  end

  get '/charts/new' do
    if logged_in?
      erb :"/charts/new_chart"
    else
    #add flash message?
      redirect "/login"
    end
  end

  post '/charts' do
    binding.pry
    redirect "/charts"
  end
#---
end
