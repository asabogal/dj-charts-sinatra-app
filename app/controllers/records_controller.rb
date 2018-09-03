class RecordsController < ApplicationController

    get '/records/:id/edit' do
      if logged_in? && current_user
        @record = Record.find_by_id(params[:id])
        @chart = Chart.find_by_id(@record.chart_id)
          if @chart.user == current_user
            erb :"/records/edit_record"
          else
            flash[:notice] = "You can only edit records from your charts!"
            redirect "/users/#{current_user.slug}/charts"
          end
        else
          flash[:notice] = "Please log in to do that."
          redirect "/login"
        end
      end

    get '/records/new' do
      if logged_in? && current_user
        if !params.empty?
          @chart = Chart.find_by_id(params[:chartid])
            if @chart.user == current_user
              erb :"/records/new_record"
            else
              flash[:notice] = "You dont have permission to do that"
              redirect "/users/#{current_user.slug}"
            end
        else
          flash[:notice] = "You can only add records directly from your charts!"
          redirect "/users/#{current_user.slug}/charts"
        end
      else
        flash[:notice] = "Please log in to do that."
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
          redirect back
        elsif params.include?(:chartid)
          @chart = Chart.find_by_id(params[:chartid])
          @record = Record.create(params[:record])
          @record.update(chart_id: @chart.id)
          @record.save
          redirect "/charts/#{@chart.slug}"
        else
          @record = Record.create(params[:record])
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
        @chart = Chart.find_by_id(@record.chart_id)
          if @chart.user == current_user && @record.update(params[:record])
            @record.save
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
      if logged_in?
        @record = Record.find_by_id(params[:id])
        @chart = Chart.find_by_id(@record.chart_id)
          if @chart.user == current_user
            @record.delete
            flash[:notice] = "Record successfully deleted"
            redirect "/charts/#{@chart.slug}"
          else
            flash[:notice] = "You dont have permission to do that"
            redirect  "/user/#{current_user.slug}"
          end
          flash[:notice] = "Please login to do that!"
          redirect "/login"
      end
    end

#---
end
