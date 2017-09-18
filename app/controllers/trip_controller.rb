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
   @trip = Trips.find(params[:id])
   erb :'trips/show_trips'
 end


 	get '/trips/:id/edit' do
 		@trip = Trips.find(params[:id])
 		erb :'/trips/edit'
 	end

  patch '/trips/:id' do #edit action
   @trip = Trips.find(params[:id])
   @trip.update(city: params[:city], interests: params[:interests], notes: params[:notes])
  #  @trip.save
   redirect to "/trips/#{@trip.id}"
 end


 #
 #   delete '/trips/:id/delete' do
 #     @trip = Trips.find(params[:id])
 #     if current_user.id == @trip.user_id
 #       @trip.delete
 #       redirect '/trips/trips'
 #     else
 #       redirect "/login"
 #     end
 #   end
 # end

 delete '/trips/:id' do
  if !logged_in? && !current_user
    redirect to '/login'
  else
    @trip = Trips.find_by_id(params[:id])
    @trip.delete
    redirect'/trips'

  end
end
end
