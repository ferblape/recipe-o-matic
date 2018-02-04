class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:authenticate]

  def authenticate
    session[:admin_user] = request.env['omniauth.auth'].info.name

    if admin?
      redirect_to '/' and return
    else
      render text: '401 Unauthorized', status: 401
    end
  end

  def logout
    session[:admin_user] = nil
    redirect_to '/' and return
  end
end
