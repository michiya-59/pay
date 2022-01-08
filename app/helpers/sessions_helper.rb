# frozen_string_literal: true

module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) unless session[:user_id].nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    current_user && forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !session[:user_id].nil?
  end
end
