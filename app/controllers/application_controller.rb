# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include(SessionsHelper)

  def login(user_id)
    session[:user_id] = user_id
  end
end
