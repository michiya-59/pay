# frozen_string_literal: true

class SessionsController < ApplicationController
  protect_from_forgery except: [:destroy]
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      login(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to suppliers_path(is_side_business: false)
    else
      flash.now[:danger] = '正しくログイン情報を入力してください'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
    flash[:danger] = "ログアウトしました"
  end
end
