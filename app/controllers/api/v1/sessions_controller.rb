class Api::V1::SessionsController < ApplicationController

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]

    if
    user = user_email.present? && User.find_by(email: user_email)


      if user.valid_password? user_password
        sign_in user, store: false
        user.generate_authentication_token!
        user.save
        render json: user, location: [:api, user]
      else
        render json: { errors: "Invalid password" } #, status: 422
      end

    else
      render json: {errors: 'email not found'}
    end

  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    render json: user
  end

end
