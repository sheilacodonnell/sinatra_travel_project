class TripController < ApplicationController

  get '/trips' do
    redirect_if_not_logged_in
    @trips = current_user.trips
      erb :'trips/trips'
  end

## Makes a new trip
  get '/trips/new' do 
    redirect_if_not_logged_in
    erb :'trips/create_trip'
  end

  post '/trips' do
    redirect_if_not_logged_in
    @trip = current_user.trips.create(
      :city => params[:city],
      :interests => params[:interests],
      :notes => params[:notes]
      )
       @trip.save 
       erb :'trips/show_trips'
    end

# Builds a new trip associated with the trip id
  get '/trips/:id' do
    redirect_if_not_logged_in
    find_trip
    erb :'trips/show_trips'
  end

  get '/trips/:id/edit' do
    redirect_if_not_logged_in
    find_trip
    erb :'trips/edit'
  end

  patch '/trips/:id' do
    find_trip
    @trip.city = params[:city]
    @trip.interests = params[:interests]
    @trip.notes = params[:notes]
    @trip.save
    redirect "/trips/#{@trip.id}"
  end

  delete '/trips/:id/delete' do
    find_trip.delete
    redirect to '/trips'
  end

  private

    def find_trip
      @trip = Trip.find_by_id(params[:id])
    end

end




