class Report2 < ActiveRecord::Base
  attr_accessible :id, :item_id, :name, :col1, :col2, :col3, :col4, :col5, :col6, :col7, :col8, :col9, :col10, :col11, :col12
  attr_accessor :col13, :col14, :col15, :col16, :col17, :col18, :col19, :col20, :col21, :col22, :col23, :col24, :col25, :col26, :col27, :col28, :col29, :col30


  def self.median(array)
    sorted = array.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end
