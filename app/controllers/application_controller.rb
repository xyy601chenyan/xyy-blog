class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = '您不是管理员，不能进行该操作'
      redirect_to root_path
    end
  end


end
