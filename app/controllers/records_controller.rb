class RecordsController < ApplicationController

  # need paths:
    # get /records/<%=record.id%>/edit

    #post /records/delete" do
      # record.id.delete ?
    # end

    get '/records' do
      @records = Record.all
      erb :"/records/index"
    end

    
#---
end
