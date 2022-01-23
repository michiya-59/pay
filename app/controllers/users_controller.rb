# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def user_confirm_new
    @user = User.new(user_params)
    render 'new' unless @user.valid?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to suppliers_path(is_side_business: false)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
