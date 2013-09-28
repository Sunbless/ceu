class ApplicationController < ActionController::Base
  protect_from_forgery

  def allow_admin_access
    if !current_user.try(:admin?) 
      redirect_to :root and return
    end
  end
end
