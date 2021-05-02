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
   @user = user_name 
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

  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit.html"
  # end

  # # PATCH: /users/5
  # patch "/users/:id" do
  #   redirect "/users/:id"
  # end

  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  # end
  private 
  def set_user
    params[:name] != "" && params[:email] != "" && params[:password]
  end

  def set_user_id
    User.find_by(id: params[:id])
  end 

  def user_name
    User.find_by(name: params[:name])
  end 
end
