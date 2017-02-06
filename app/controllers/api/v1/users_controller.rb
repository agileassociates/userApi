class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json
  include Authenticable


  def show
    #respond_with User.find(params[:id])

    @user = User.find(params[:id])
    if @user
      render json: @user
    end

  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, location: [:api, user]
    else
      if user.errors.any?
        if ! user.errors[:email].empty?
          render json: { errors: "Email: #{user.errors[:email]}"}
        else
          render json: { errors: "Password: #{user.errors[:password]}"}
        end
      end
    end
  end

  def update
    user = current_user

    user.user_profile = params[:user_profile]
    if user.update(user_params)
      render json: user, location: [:api, user]
    else
      render json: { errors: user.errors }
    end
  end

  def profile
    user = User.find(params[:id])
    @profile_prefix = 'https://s3-us-west-1.amazonaws.com/truegrowthsf/profiles/'
    @profile_suffix = params[:url]
    @profile_prefix << @profile_suffix
    user.user_profile = @profile_prefix

    if user.save
      render json: user, location: [:api, user]
    else
      render json: { errors: user.errors }
    end
  end

  def destroy
    #user = User.find(params[:id])
    #user.destroy
    current_user.destroy
  end

  def favor
    @user = User.find(params[:user_id])
    @user_id = params[:user_id]
    @photo_id = params[:photo_id]
    @photo_url = params[:photo_url]
    sql = " update users set favorites = favorites || '\"#{@photo_id}\"=>\"#{@photo_url}\"'::hstore where id=#{@user_id};"
    ActiveRecord::Base.connection.execute(sql)

    if user.save
      render json: user
    else
      render json: { errors: user.errors }
    end
  end

  def unfavor
    @user = User.find(params[:user_id])
    @photo_id = params[:photo_id]
    @user_id = params[:user_id]
    sql = "update users set favorites = delete(favorites, '#{@photo_id}') where id=#{@user_id};"
    ActiveRecord::Base.connection.execute(sql)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :id, :user_profile)
  end

end
