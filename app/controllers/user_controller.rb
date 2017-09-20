class UsersController < ApplicationController
  get '/signup' do #user signup
    if !logged_in?(session)
      erb :'/users/signup'
    else
      redirect "/trips"
    end
  end

  post '/signup' do
    if logged_in?(session)
      erb :'/trips/trips'
    else
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    @user.save
     session[:user_id] = @user.id
      redirect '/trips/new'
    end
  end

  get '/login' do #user login
    if !logged_in?(session)
      erb :'/users/login'
    else
      redirect "/trips"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/trips'
    else
      redirect '/signup'
    end
  end

  get '/logout' do #user logout
    if logged_in?(session)
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do # user show page
    @user = User.find_by_slug(params[:slug])
    @trips = @user.trips
    erb :'/users/show'
  end

end

# class UsersController < ApplicationController
#
#   get '/login' do
#     if !logged_in?
#       erb :'users/login'
#     else
#     redirect to '/trips/new'
#     end
#   end
#
#   get '/signup' do
#     if !logged_in?
#       erb :'users/signup'
#     else
#       redirect to '/trips'
#     end
#   end
#
#   get '/logout' do
#     if logged_in?
#       session.clear
#       redirect to '/'
#     else
#       redirect to '/'
#     end
#   end
#
#   post '/login' do
#     user = User.find_by(username: params[:username])
#     if user && user.authenticate(params[:password])
#       session[:user_id] = user.id
#       redirect to '/trips'
#     else
#       redirect to '/signup'
#     end
#   end
#
#   post '/signup' do
#     @user = User.new(username: params[:username], email: params[:email], password: params[:password])
#     @user.save
#     if @user.save
#       session[:user_id] = @user.id
#       redirect to '/trips'
#     else
#       redirect to '/signup'
#     end
#   end
#
# end
