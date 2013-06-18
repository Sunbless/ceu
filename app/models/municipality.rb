class Municipality < ActiveRecord::Base
  attr_accessible :district_id, :municipality, :id
  belongs_to :district
  has_many :users
  has_many :centers
  has_many :laboratories
  has_many :phis
  validates_presence_of :municipality
end
