class Report < ActiveRecord::Base
  attr_accessible :id, :item_id, :name, :col1, :col2, :col3, :col4, :col5, :col6, :col7, :col8, :col9, :col10, :col11, :col12


  def self.median(array)
    sorted = array.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

end