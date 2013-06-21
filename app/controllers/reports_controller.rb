class ReportsController < ApplicationController

  def index
    @fbih = District.where(:entity_id => 9000)
    @rs = District.where(:entity_id => 9100)
    @entities = Entity.all
  end


  def make_report
    redirect_to(reports_path, :notice => t(:select_entity_and_week)) if (params[:entity].blank? || params[:week].blank? || params[:week].to_i < 1 || params[:week].to_i > 51) 
    @week_dates = week_dates params[:week].to_i
    @week = params[:week]
  end

  def week_dates( week_num )
    year = Time.now.year
    week_start = Date.commercial( year, week_num, 1 )
    week_end = Date.commercial( year, week_num, 7 )
    week_start.strftime( "%Y-%m-%d" ) + ' - ' + week_end.strftime( "%y-%m-%d" )
  end


end
