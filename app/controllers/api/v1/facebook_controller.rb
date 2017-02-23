class FacebookController < ApplicationController

  def show
    @facebook = Facebook.find(params[:id])
    if @facebook
      render json: @facebook
    else
      facebook = Facebook.new(facebook_params)
      if facebook.save
        render json: facebook, location: [:api, facebook]
      end
    end
  end

  private

  def facebook_params
    params.require(:facebook).permit(:email, :id)
  end


end
