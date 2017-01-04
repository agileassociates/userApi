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
          render json: { errors: "Invaid Password"}
        end
      end
    end
  end

  def update
    #user = User.find(params[:id])
    user = current_user

    if user.update(user_params)
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
