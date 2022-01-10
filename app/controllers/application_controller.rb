# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include(SessionsHelper)
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
