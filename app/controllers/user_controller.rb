class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/cities'
    else
    erb :'users/signup'
  end
end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id

        redirect '/cities'
    end
  end

get '/login' do
  if !logged_in?
    erb :'users/login'
  else
    redirect '/cities'
  end
end

post '/login' do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/cities'
  else
    redirect '/signup'
  end
end

get '/logout' do
  if logged_in?
    session.destroy
    redirect '/login'
  else
    redirect '/'
  end
end

get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'/users/show'
end
end
