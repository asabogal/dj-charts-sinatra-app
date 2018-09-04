class ChartsController < ApplicationController

  get '/charts' do
    @charts = Chart.all
    erb :"/charts/index"
  end

  get '/charts/new' do
    if logged_in?
      erb :"/charts/new_chart"
    else
      flash[:notice] = "Please login to do that!"
      redirect "/login"
    end
  end

  get '/charts/:id/:slug/edit' do
    if logged_in? && current_user
        @chart = Chart.find_by_id(params[:id])
          if @chart.user == current_user
            erb :"/charts/edit_chart"
          else
            flash[:notice] = "You dont have permission to do that"
            redirect "/charts"
          end
    else
      flash[:notice] = "Please login to do that!"
      redirect "/login"
    end
  end

  get '/charts/:id/:slug' do
    @chart = Chart.find_by_id(params[:id])
      erb :"charts/show_chart"
  end


  post '/charts' do
    if logged_in? && current_user
      if params[:chart][:name] == "" || params[:record][:title] == "" || params[:record][:artist] == "" || params[:record][:label] == ""
        flash[:notice] = "Please fill in all fields"
        redirect "/charts/new"
      else
        @chart = Chart.create(params[:chart])
        @chart.update(user_id: current_user.id)
        @record = Record.create(params[:record])
        @record.update(chart_id: @chart.id)
        @record.save
        @chart.save
        redirect "/users/#{current_user.slug}/charts"
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
                  @chart.save
                  redirect "/charts/#{@chart.slug}"
                else
                  flash[:notice] = "Something went wrong, please try again."
                  redirect "/charts/#{@chart.slug}/edit"
                end
            else
              flash[:notice] = "You dont have permission to do that"
              redirect "/users/#{current_user.slug}"
            end
          end
          redirect "/login"
        end
      end

    delete '/charts/:id/:slug/delete' do
      if logged_in?
        @chart = Chart.find_by_id(params[:id])
        if @chart && @chart.user == current_user
          @chart.delete
          flash[:notice] = "Chart successfully deleted"
          redirect "/users/#{current_user.slug}/charts"
        else
          flash[:notice] = "You dont have permission to do that"
          redirect  "/charts"
        end
      else
        flash[:notice] = "Please login to do that!"
        redirect "/login"
      end
    end


#---
end
