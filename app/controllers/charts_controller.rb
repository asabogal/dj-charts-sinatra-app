class ChartsController < ApplicationController

  get '/charts' do
    @charts = Chart.all
    erb :"/charts/index"
  end

  get '/charts/new' do
    if logged_in?
      erb :"/charts/new_chart"
    else
      # flash[:notice] = "You must be logged in to crate a new chart"
      redirect "/login"
    end
  end

  get '/charts/:slug/edit' do
    @chart = Chart.find_by_slug(params[:slug])
    erb :"/charts/edit_chart"
  end

  get '/charts/:slug' do
    @chart = Chart.find_by_slug(params[:slug])
    erb :"charts/show_chart"
  end


  post '/charts' do
    if logged_in?
      if params[:chart][:name] == "" || params[:record][:title] == "" || params[:record][:artist] == "" || params[:record][:label] == ""
        flash[:notice] = "Please fill in all fields"
        redirect "/charts/new"
      else
        @chart = Chart.create(params[:chart])
        @chart.update(user_id: current_user.id)
        @record = Record.create(params[:record])
        @record.update(chart_id: @chart.id)
        @chart.records << @record
        redirect "/charts"
      end
    else
      redirect "/login"
    end
  end
#---
end
