class Api::V1::PhotosController < ApplicationController
  respond_to :json

  def create

    photo = Photo.new(:user_id => params[:photo][:user_id].to_i, :url_suffix => params[:photo][:url],
      :user_profile => params[:photo][:user_profile])
    photo.url << photo.url_suffix
    @user = User.find(params[:user_id])
    photo.user_name = @user.email


    if photo.save
      render json: photo
    else
      render json: { errors: photo.errors }
    end
  end

  def new

  end

  def index
    @count = Photo.count
    @first = Photo.first
    @first.count = @count
    @first.save
    @photos = Photo.all.order('id asc')
    render json: @photos
  end

  def liked
    @photo = Photo.find(params[:photo_id])
    @user_id = params[:user_id]
    @photo_id = params[:photo_id]
    sql = " update photos set likes = likes || '\"#{@user_id}\"=>\"yes\"'::hstore where id=#{@photo_id};"
    ActiveRecord::Base.connection.execute(sql)

    if photo.save
      render json: photo
    else
      render json: { errors: photo.errors }
    end
  end

  def hated
    @photo = Photo.find(params[:photo_id])
    @photo_id = params[:photo_id]
    @user_id = params[:user_id]
    sql = "update photos set likes = delete(likes, '#{@user_id}') where id=#{@photo_id};"
    ActiveRecord::Base.connection.execute(sql)

    if photo.save
      render json: photo
    else
      render json: { errors: photo.errors }
    end
  end

  def delete
  end
end
