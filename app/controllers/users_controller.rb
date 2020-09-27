class UsersController < ApplicationController

  def new
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully Registered"
      redirect_to '/profile'
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :name,
      :address,
      :city,
      :state,
      :zip
    )
  end
end
