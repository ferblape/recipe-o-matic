class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def searching?
    params[:term].present?
  end
  helper_method :searching?
end
