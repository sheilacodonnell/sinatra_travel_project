class UsersController < ApplicationController
  get '/signup' do #user signup
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/trips'
    end
  end

  post '/signup' do
    if user_params.empty?
      redirect '/signup'
    else
    @user = User.create(username: params[:username], password: params[:password])
    @user.save
     session[:user_id] = @user.id
     redirect '/trips'
    end
  end

  get '/login' do #user login
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/trips'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    # does the user exist and is the password correct?
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/trips'
      else
        redirect '/signup'
      end
  end

  get '/logout' do #user logout
      # logged_in?
      session.clear
      redirect '/'
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
end
