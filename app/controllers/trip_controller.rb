class TripController < ApplicationController

  get '/trips' do
    if logged_in?(session)
      # @user = User.find(session[:user_id])
      user = current_user(session)

      @trips = Trips.all
      # (!--using this as a placeholder. it brings up all trips created, regardless of user)
      # @trips = @user.trips.all why doesnt this work? uninitialized constant User::Trip error
      erb :'trips/trips'
    else
      redirect to '/login'
    end
  end

get '/trips/new' do # takes you to the create a new trip
  if logged_in?(session)
    erb :'trips/create_trip'
  else
    redirect to '/login'
  end
end

post '/trips' do
      user = current_user(session)
      @trip = Trips.create(
        :city => params[:city],
        :interests => params[:interests],
        :notes => params[:notes],
        :user_id => user.id)
      redirect to "/trips/#{@trip.id}"
    end

  get '/trips/:id' do
    if logged_in?(session)
      @trip = Trips.find_by_id(params[:id])
      if @trip.user_id == session[:user_id]
        erb :'trips/show_trips'
      elsif @trip.user_id != session[:user_id]
        redirect '/trips'
      end
    else
      redirect to '/'
    end
  end

  get '/trips/:id/edit' do
    if logged_in?(session)
      @trip = Trips.find_by_id(params[:id])
      if @trip.user_id == session[:user_id]
        erb :'trips/edit'
      else
        redirect to '/trips'
        end
    else
      redirect to '/'
    end
  end

  patch '/trips/:id' do
    if params[:city] == ""
      redirect to "/trips/#{params[:id]}/edit"
    else
      @trip = Trips.find_by_id(params[:id])
      @trip.city = params[:city]
      @trip.interests = params[:interests]
      @trip.notes = params[:notes]
      @trip.user_id = current_user(session).id
      @trip.save
      redirect to "/trips/#{@trip.id}"
    end
  end

  delete '/trips/:id/delete' do
    if logged_in?
      @trip = Trips.find_by_id(params[:id])
      if @trip.user_id == session[:user_id]
        @trip.delete
        redirect to '/trips'
      end
    else
      redirect to '/login'
    end
  end

end
