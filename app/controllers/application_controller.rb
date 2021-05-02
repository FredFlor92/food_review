#require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "RestuarantReviewApp"
  end

  get "/" do
    erb :welcome
  end
  get '/logout' do
    session.clear
    redirect '/'
  end
  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def authorized
      redirect '/' if !logged_in?
    end

  end

end
