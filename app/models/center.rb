class Center < ActiveRecord::Base
  #AKA DZ
  attr_accessible :municipality_id, :name, :code, :uid, :phi_id
  belongs_to :municipality
  belongs_to :phi
  has_many :hes
  has_many :cases
  validates_presence_of :name
end
