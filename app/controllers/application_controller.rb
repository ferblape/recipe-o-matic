class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def searching?
    params[:term].present?
  end
  helper_method :searching?

  def admin?
    !session[:admin_user].blank? &&
      session[:admin_user] == 'blat'
  end
  helper_method :admin?

  protected

  def admin_required
    redirect_to '/auth/twitter' unless admin?
  end
end
