require 'csv'
class Icd < ActiveRecord::Base
  attr_accessible :both, :code, :disease_bsn, :disease_eng, :int
  has_many :cases
  validates_presence_of :disease_bsn


  def name
    self.try(:code) ? self.code + ' - ' + self.disease_bsn : self.disease_bsn
  end

  def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:code => row['Code'])
      if existing.count == 0
        imported += 1
        import = self.new
        import.code = row['Code']
        import.disease_bsn = row['Disease_BSN']
        import.disease_eng = row['Disease_Eng']
        import.int = row['int']
        import.both = row['both']
        import.save
      end

    end

    imported;

  end


end
