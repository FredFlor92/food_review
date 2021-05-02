class FoodreviewsController < ApplicationController

  # GET: /foodreviews
  get "/foodreviews" do
    erb :"/foodreviews/index.html"
  end

  # GET: /foodreviews/new
  get "/foodreviews/new" do
    erb :"/foodreviews/new.html"
  end

  # POST: /foodreviews
  post "/foodreviews" do
    redirect "/foodreviews"
  end

  # GET: /foodreviews/5
  get "/foodreviews/:id" do
    erb :"/foodreviews/show.html"
  end

  # GET: /foodreviews/5/edit
  get "/foodreviews/:id/edit" do
    erb :"/foodreviews/edit.html"
  end

  # PATCH: /foodreviews/5
  patch "/foodreviews/:id" do
    redirect "/foodreviews/:id"
  end

  # DELETE: /foodreviews/5/delete
  delete "/foodreviews/:id/delete" do
    redirect "/foodreviews"
  end
end
