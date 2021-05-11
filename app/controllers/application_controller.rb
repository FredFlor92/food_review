class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

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

    def redirect_if_not_logged_in
      redirect '/' if !logged_in?
    end

    def redirect_if_not_authorized
      if @foodreview.user != current_user
      redirect "/users/#{current_user.id}" 
      end 
    end
  end

end
