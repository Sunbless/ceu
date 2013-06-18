class ApplicationController < ActionController::Base
  protect_from_forgery

  def allow_admin_access
    redirect_to :root if !current_user.try(:admin?) 
  end
end
