class ApplicationController < ActionController::Base
  before_action :authenticate_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user
   redirect_to '/login' unless current_user
  end
end
