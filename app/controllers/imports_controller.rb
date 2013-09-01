# encoding: UTF-8
require 'csv'

class ImportsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def import
    if !params[:file]
      redirect_to imports_path, :flash => { error: "Greška: niste izabrali datoteku" }
    end

    data = RemoteTable.new params[:file].path

    case params[:table]
    when 'icds' #done
      imported_rows = Icd.import data
    when 'agents' #done
      imported_rows = Agent.import data
    when 'cases' #done
      imported_rows = Case.import data
    when 'phis' #done
      imported_rows = Phi.import data
    when 'laboratories' #done
      imported_rows = Laboratory.import data
    when 'hes' #done
      imported_rows = He.import data
    when 'centers' 
      imported_rows = Center.import data
    when 'users'
      imported_rows = User.import data
    else
      redirect_to imports_path, :flash => { error: 'Greška: pogrešna tabela' }
    end
    # @imported_rows = imported_rows
    # @data = data #tmp

    redirect_to imports_path, notice: "Datoteka uvezena: "+imported_rows.to_s+"/"+data.rows.length.to_s
  end

end