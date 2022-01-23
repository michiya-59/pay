# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include(SessionsHelper)
  before_action :now_time_get

  def redirect_when_no_logged_in
    return if current_user

    redirect_to login_path
    flash[:not_login] = 'ログインされてません。ログインしてください。'
  end

  def now_time_get
    @now_yaer = Time.zone.today.strftime('%Y')
  end
end
