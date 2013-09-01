class Phi < ActiveRecord::Base
  attr_accessible :abbrev, :address, :district_id, :email, :epidemiologist, :fax, :full_bsn, :full_eng, :mail_no, :municipality_id, :phone, :post, :municipality_id
  belongs_to :district
  belongs_to :municipality
  has_many :cases
  has_many :centers
  validates_presence_of :abbrev


  def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:abbrev => row['Abbrev'])
      if existing.count == 0

        import = self.new
        import.abbrev = row['Abbrev']
        import.address = row['Address_street']
        import.full_bsn = row['Full_bsn']
        import.full_eng = row['Full_egn']
        import.mail_no = row['Mail_no']
        import.post = row['city']
        import.phone = row['phone']
        import.fax = row['fax']
        import.epidemiologist = row['epidemiologist']
        import.email = row['email']
        import.district_id = row['districtID']

        if import.save
          imported += 1
        else
          puts import.errors.inspect
        end
      end

    end

    imported;

  end


end
