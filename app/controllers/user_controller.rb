class UsersController < ApplicationController
  before'/users/*' do
    authorized
  end

  get "/users" do
    @user = User.all
    erb :"/users/index.html"
  end

  get "/register" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else 
      erb :"/users/new.html"
    end

  end

  post "/users" do
    if set_user
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/'
    end 
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'users/login.html'
    end
  end

  post '/login' do
   @user = user_email 
   if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
   else
    redirect '/'
   end 
  end

  get '/users/:id' do
    @user = set_user_id
    if @user == current_user
      erb :'users/show.html'
    else
      redirect "/users/#{current_user.id}"
    end
  end 
  
  private 
  def set_user
   params[:email] != "" && params[:password]
  end

  def set_user_id
    User.find_by(id: params[:id])
  end 

  def user_email
    User.find_by(email: params[:email])
  end 
end
