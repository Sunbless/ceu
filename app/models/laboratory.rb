class Laboratory < ActiveRecord::Base
  attr_accessible :email, :municipality_id, :name, :phone, :uid
  belongs_to :municipality
  has_many :cases
  validates_presence_of :name
end
