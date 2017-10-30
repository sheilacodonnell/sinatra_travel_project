require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "top_secret"
  end

  get '/' do
    erb :index
  end

  helpers do

  def redirect_if_not_logged_in
    if !logged_in?
    redirect "/login"
    end
  end

    def logged_in? #=> nil || integer
      !!current_user
    end

  #   def current_user #=> User instance || nil
  #     if @current_user 
  #       @current_user
  #     else 
  #       @current_user = User.find_by(id: session[:user_id])
  #     end
  #   end
  # end

     def current_user
      @current_user ||= User.find_by_id(session[:user_id]) 
    end
  end

 end
