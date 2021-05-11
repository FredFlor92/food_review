class FoodreviewsController < ApplicationController
  before '/foodreviews/*' do
    redirect_if_not_logged_in
  end

  get "/foodreviews" do
    @foodreview = Foodreview.all
    erb :"/foodreviews/index.html"
  end

  get "/foodreviews/new" do
    erb :"/foodreviews/new.html"
  end

  post "/foodreviews" do
    if entry
      @foodreview = Foodreview.create(content: params[:content], user_id: current_user.id)
      redirect "/foodreviews/#{@foodreview.id}"
    else
      redirect '/foodreviews/new'
    end 
  end

  get "/foodreviews/:id" do
    @foodreview = find_reviews
    redirect_if_not_authorized
    erb :"/foodreviews/show.html"
  end


  get "/foodreviews/:id/edit" do
    @foodreview = find_reviews
    redirect_if_not_authorized
      erb :"/foodreviews/edit.html"
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

  delete "/foodreviews/:id" do
    @foodreview = find_reviews
    redirect_if_not_authorized
    @foodreview.destroy
    redirect '/foodreviews'
  end

  private 

  def entry
    params[:content] != ""
  end 

  def find_reviews
    Foodreview.find_by(id: params[:id])
  end 

end