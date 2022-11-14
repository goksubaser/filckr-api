class StaticPagesController < ApplicationController
  def index
  end
  def search
    temp = "/" + search_params[:user_id]
    redirect_to temp
  end

  def show
    require 'flickr'
    flickr = Flickr.new Figaro.env.pusher_key, Figaro.env.pusher_secret
    list   = flickr.people.getPublicPhotos({api_key: Figaro.env.pusher_key, user_id: params[:id]})

    @photos = []
    list.each do |photo|
      info = flickr.photos.getInfo(:photo_id => photo.id)
      @photos.push(Flickr.url_m(info))
    end
  end

  private
  def search_params
    params.permit(:user_id)
  end
end
