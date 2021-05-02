class FoodreviewsController < ApplicationController
  before'/users/*' do
    authorized
  end

  get "/foodreviews" do
    @foodreview = Foodreview.all
    erb :"/foodreviews/index.html"
  end

  get "/foodreviews/new" do
    erb :"/foodreviews/new.html"
  end

  post "/foodreviews/new" do
    if entry
      @foodreview = Foodreview.create(content: params[:content], user_id: current_user.id)
      redirect "/foodreviews/#{@foodreview.id}"
    else
      redirect '/foodreviews/new'
    end 
  end

  get "/foodreviews/:id" do
    @foodreview = find_reviews
    if @foodreview.user == current_user  
      erb :"/foodreviews/show.html"
    else
      redirect "/users/#{current_user.id}"
    end 
  end


  get "/foodreviews/:id/edit" do
    @foodreview = find_reviews
    if @foodreview.user == current_user
      erb :"/foodreviews/edit.html"
    else
      redirect "/users/#{current_user.id}"
    end 
  end

  patch "/foodreviews/:id" do
    @foodreview = find_reviews
    if entry 
      @foodreview.update(content: params[:content])
      redirect "/foodreviews/#{@foodreview.id}"
    else 
      redirect '/foodreviews'
    end
  end

  delete "/foodreviews/:id/delete" do
    @foodreview = find_reviews
    if @foodreview.user == current_user
      @foodreview.destroy
      redirect '/foodreviews'
    else
      redirect "/users/#{current_user.id}"
    end 
  end

  private 

  def entry
    params[:content] != ""
  end 

  def find_reviews
    Foodreview.find_by(id: params[:id])
  end 

end
