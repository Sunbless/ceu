class MainController < ApplicationController
  before_filter :authenticate_user!

  def index_action
  end

end
