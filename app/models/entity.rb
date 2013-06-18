class Entity < ActiveRecord::Base
  attr_accessible :abbr, :description, :description_eng, :id
  has_many :districts
  validates_presence_of :abbr, :description, :description_eng
end
