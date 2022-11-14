class StaticPagesController < ApplicationController
  def index
  end
  def search
    puts(search_params[:user_id])
    require 'flickr'
    flickr = Flickr.new Figaro.env.pusher_key, Figaro.env.pusher_secret
    list   = flickr.people.getPublicPhotos({api_key: Figaro.env.pusher_key, user_id: search_params[:user_id]})

    @photos = []
    list.each do |photo|
      info = flickr.photos.getInfo(:photo_id => photo.id)
      @photos.push(Flickr.url_o(info))
      # puts(Flickr.url_o(info))
    end
    puts(@photos)

    if !@photos.empty?
      redirect_to @photos[0], allow_other_host: true
    else
      render :index, status: :unprocessable_entity
    end
  end


  private
  def search_params
    params.permit(:user_id)
  end
end
