class InterestsController < ApplicationController
  get '/interests' do
    @trip = current_user.trips
    @interests = Trip.find_by_id(params[:id])
    erb :'interests/index'
  end

  get '/interests/new' do
    @trip = current_user.trips
    erb :'interests/new'
  end


  get '/interests/:id/edit' do
    @interests = Interests.find(params[:id])
    @trip = current_user.trips
    erb :'interests/edit'
  end

  patch '/interests/:id' do
    @interests = Interests.find(params[:id])
    @interests.update(interest: params[:interest])
    redirect to "/interests/#{@interests.id}"
  end

  get '/interests/:id' do
    @interest = Interests.find_by_id(params[:id])
    erb :'interests/show'
  end

  post '/interests' do
    #binding.pry
    trip = Trip.find_by_id(params[:trip_id])
    @interests = trip.interests.create(interests: params[:interests])
    #current_user.goals.create(name: params[:name])
    redirect to "/interests"
  end

  get '/interests/:id' do
    @interests = Interests.find_by_id(params[:id])
    erb :'/interests/edit'
  end

  delete '/interests/:id' do
    @interests = Interests.find_by_id(params[:id])
    @interests.delete
    redirect '/interests'
  end


end
