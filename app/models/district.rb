class District < ActiveRecord::Base
  attr_accessible :abbr, :centar, :code, :code_stat, :entity_id, :municipalities, :name, :name_eng, :population, :id
  belongs_to :entity
  has_many :municipalities
  has_many :phis
  has_many :cases
  has_many :users
  validates_presence_of :abbr, :name, :name_eng

end
