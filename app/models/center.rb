class Center < ActiveRecord::Base
  #AKA DZ
  attr_accessible :municipality_id, :name, :code, :uid, :phi_id
  belongs_to :municipality
  belongs_to :phi
  has_many :hes
  has_many :cases
  validates_presence_of :name


    def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:uid => row['ID'])
      if existing.count == 0

        import = self.new
        import.uid = row['ID']
        import.code = row['code']
        import.name = row['dzName']
        import.municipality_id = row['municipality']

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
