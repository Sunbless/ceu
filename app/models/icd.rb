class Icd < ActiveRecord::Base
  attr_accessible :both, :code, :disease_bsn, :disease_eng, :int
  has_many :cases
  validates_presence_of :disease_bsn

  def name
    self.try(:code) ? self.code + ' - ' + self.disease_bsn : self.disease_bsn
  end
end
