# class UsersController < ApplicationController
#
#   get '/signup' do
#     if logged_in?
#       redirect to '/trips'
#     else
#     erb :'users/signup'
#   end
# end
#
#   post '/signup' do
#     if params[:username].empty? || params[:email].empty? || params[:password].empty?
#         redirect '/signup'
#     else
#       user = User.create(username: params[:username], email: params[:email], password: params[:password])
#       session[:user_id] = user.id
#
#         redirect '/trips'
#     end
#   end
#
# get '/login' do
#   if !logged_in?
#     erb :'users/login'
#   else
#     redirect '/trips'
#   end
# end
#
# post '/login' do
#   user = User.find_by(:username => params[:username])
#   if user && user.authenticate(params[:password])
#     session[:user_id] = user.id
#     redirect '/trips'
#   else
#     redirect '/signup'
#   end
# end
#
# get '/logout' do
#   if logged_in?
#     session.destroy
#     redirect '/login'
#   else
#     redirect '/'
#   end
# end
#
# # get '/users/:slug' do
# #   @user = User.find_by_slug(params[:slug])
# #   erb :'/users/show'
# # end
# end

# require 'rack-flash'

class UsersController < ApplicationController
#use Rack::Flash

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
    redirect to '/trips'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/trips'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to 'login'
    else
      redirect to '/'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/trips'
    else
      redirect to '/signup'
    end
  end

  post '/signup' do #check validation before submitting
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/trips/new'
    else
      redirect to '/signup'
    end
  end

end
