class RecordsController < ApplicationController


    get '/records/:id/edit' do
      if logged_in? && current_user
        @record = Record.find_by_id(params[:id])
        erb :"/records/edit_record"
      else
        flash[:notice] = "Please log in to do that"
        redirect "/login"
      end
    end

    get '/records/new' do
      if logged_in? && current_user
        if !!params
          @chart = Chart.find_by_id(params[:chartid])
          erb :"/records/new_record"
        else
          #flash messag = "You can only add tracks your chart"
          redirect "/charts"
        end
      else
        # flash[:notice] = "You must be logged in to crate a new chart"
        redirect "/login"
      end
    end

    get '/records' do
        @records = Record.all
        erb :"/records/index"
    end

  post '/records' do
    if logged_in? && current_user
        if params[:title] == "" || params[:artist] == "" || params[:label] == ""
          flash[:notice] = "Please fill in all fields"
          redirect "/records/new"
        elsif params.include?(:chartid)
          @chart = Chart.find_by_id(params[:chartid])
          @record = Record.create(title: params[:title], artist: params[:artist], label: params[:label])
          @record.update(chart_id: @chart.id)
          @record.save
          redirect "/charts/#{@chart.slug}"
        else
          @record = Record.create(title: params[:title], artist: params[:artist], label: params[:label])
          redirect "/records"
        end
    else
      #flash message
      redirect "/login"
    end
  end


    patch '/records/:id' do
      if logged_in? && current_user
        @record = Record.find_by_id(params[:id])
          if @record.update(title: params[:record][:title], artist: params[:record][:artist], label: params[:record][:label])
            @record.save
            @chart = Chart.find_by_id(@record.chart_id)
            redirect "/charts/#{@chart.slug}"
          else
            flash[:notice] = "Please fill in all fields"
            redirect "/records/#{@record.id}/edit"
          end
        else
          flash[:notice] = "Please log in to do that"
          redirect "/login"
      end
    end

    delete '/records/:id/delete' do
      @record = Record.find_by_id(params[:id])
      @chart = Chart.find_by_id(@record.chart_id)
      @record.delete
      redirect "/charts/#{@chart.slug}"
    end

#---
end
