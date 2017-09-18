class TripController < ApplicationController

  get '/trips' do
    if !logged_in?
      redirect to '/login'
    else
      # @user = current_user
      @trips = Trips.all
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


 get '/trips/:id/edit' do #load edit form
    if logged_in?
      @trip = Trips.find_by_id(params[:id])
      if @trip.user_id == current_user.id
        erb :'/trips/edit'
      else
        redirect to '/trips'
      end
    else
      redirect to '/login'
    end
  end

  patch '/trips/:id' do #edit action
    @trip = Trips.find_by_id(params[:trips_id])
    @trip.update(interests: params[:interests])
    redirect to "/trips/#{@trip.id}"
  end

  get '/trips/:id' do
    if logged_in?
     @trip = Trips.find_by_id(params[:trips_id])
     redirect to '/interests'
   else
     redirect to "/login"
   end
  end

 # post '/trips' do
 #   if params[:trip_name] == ""
 #     redirect to '/trips/new'
 #   else
 #    #  current_user.trips.create(trip_name: params[:trip_name])
 #    Trips.create(params[:trip_name])
 #     redirect to "/trips"
 #   end
 # end

 post '/trips' do
    @trip = Trips.new(:city => params[:city], :interests => params[:interests], :notes => params[:notes])
    @trip.save

    redirect to '/trips'
  end


 get '/trips/:id' do
   @trip = Trips.find_by_id(param[:id])
   erb :'trips/edit'
 end

  delete '/trips/:id/delete' do
    if logged_in?
      @trip = Trips.find(params[:id])
      if @trip.user_id == current_user.id
        @trip.delete
        redirect to '/trips'
      else
        redirect to '/trips'
      end
    else
      redirect to '/login'
    end
 end

end #end controller
