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
        @record.save
        # @chart.records << @record
        @chart.save
        redirect "/charts"
      end
    else
      redirect "/login"
    end
  end

  patch '/charts/:slug' do
    if logged_in?
      if params[:chart][:name] == ""
        flash[:notice] = "Please fill in the Chart Name"
        redirect "/charts/#{params[:slug]}/edit"

      else
        @chart = Chart.find_by_slug(params[:slug])
          if @chart && @chart.user == current_user

            if @chart.update(name: params[:chart][:name])
                @record = Record.create(params[:record]) unless params[:record].empty?
                @record.update(chart_id: @chart.id)
                @record.save
                # @chart.records << @record
                @chart.save
                redirect "/charts/#{@chart.slug}"
              else
                #flash message
                redirect "/charts/#{@chart.slug}/edit"
              end
            else
              #flash message: you don't have access to this page
              redirect "/charts"
            end
          end
          redirect "/login"
        end
      end

    delete '/charts/:slug/delete' do
      @chart = Chart.find_by_slug(params[:slug])
      @chart.delete
      flash[:notice] = "SUccessfully deleted Chart"
      redirect "/charts"
    end


#---
end
