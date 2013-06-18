class Center < ActiveRecord::Base
  #AKA DZ
  attr_accessible :municipality_id, :name, :code, :uid
  belongs_to :municipality
  has_many :hes
  validates_presence_of :name
end
