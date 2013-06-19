class ReportsController < ApplicationController

  def index
    @fbih = District.where(:entity_id => 9000)
    @rs = District.where(:entity_id => 9100)
    @entities = Entity.all
  end


end
