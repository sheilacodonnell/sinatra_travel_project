class TripController < ApplicationController

  get '/trips' do
    if !logged_in?
      redirect to '/login'
    else
      @user = current_user
      @trip= Trip.all
      erb :'/trips/trips'
    end
  end

  get '/trips/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/trips/create_trip'
    end
  end

  post '/trips' do
    if params[:content] == ""
      redirect to "/trips/new"
    else
      @trip = current_user.trip.create(interests: params[:interests])
      redirect to "/trips/#{@trip.id}"
    end
  end

  get '/trips/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @trip = Trip.find_by_id(params[:id])
      erb :'trips/show_trip'
    end
  end

  get '/trips/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @trip = rip.find_by_id(params[:id])
        erb :'/trips/edit_trip'
    end
  end

  patch '/trips/:id' do
    @trip = Trip.find_by_id(params[:id])
    @trip.update(content: params[:content])
    if @trip.save
      redirect to "/trips/#{@trip.id}/edit"
    end
  end

  delete '/trips/:id/delete' do
    if !logged_in?
      redirect to '/login'
    else
      @trip = Trip.find_by(params[:id])
      if current_user.id == @trip.user_id
        @trip.delete
        redirect to '/trips'
      else
        redirect to "/trips"
      end
    end
  end

end
