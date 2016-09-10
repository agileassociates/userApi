class Api::V1::PhotosController < ApplicationController
  respond_to :json

  def create

    photo = Photo.new(:user_id => params[:photo][:user_id].to_i, :url_suffix => params[:photo][:url])
    photo.url << photo.url_suffix
    if photo.save
      render json: photo
    else
      render json: { errors: photo.errors }
    end
  end

  def new
    
  end

  def index
    @photos = Photo.all
    render json: @photos
  end

  def delete
  end
end
