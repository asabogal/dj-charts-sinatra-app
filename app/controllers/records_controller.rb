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

    get '/records' do
        @records = Record.all
        erb :"/records/index"
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
