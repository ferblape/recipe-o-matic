class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def searching?
    params[:q].present?
  end
  helper_method :searching?
end
