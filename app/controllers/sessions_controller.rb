# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user
      sessions[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_url
    end
  end
end
