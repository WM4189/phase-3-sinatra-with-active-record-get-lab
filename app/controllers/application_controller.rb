class ApplicationController < Sinatra::Base

  # # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'


  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakery = Bakery.all     #.order(:title).limit(10)
    # return a JSON response with an array of all the bakery data
    bakery.to_json
  end

   # use the :id syntax to create a dynamic route
   get '/bakeries/:id' do
    # look up the bakery in the database using its ID
    bakery = Bakery.find(params[:id])
    # send a JSON-formatted response of the bakery data
    bakery.to_json(include: :baked_goods)
    # game.to_json(include: :reviews)
    # game.to_json(include: { reviews: { include: :user } })
    # game.to_json(only: [:id, :title, :genre, :price], include: {
    #   reviews: { only: [:comment, :score], include: {
    #     user: { only: [:name] }
    #   } }
    # })
  end

  get '/baked_goods/by_price' do
    baked_goods = BakedGood.all.order(price: :desc)
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    baked_goods = BakedGood.all.order(price: :desc).limit(1)
    baked_goods.to_json # (only: [:name, :price])
  end


end
