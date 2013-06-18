class Phi < ActiveRecord::Base
  attr_accessible :abbrev, :address, :district_id, :email, :epidemiologist, :fax, :full_bsn, :full_eng, :mail_no, :municipality_id, :phone, :post, :municipality_id
  belongs_to :district
  belongs_to :municipality
  has_many :cases
  validates_presence_of :abbrev
end
