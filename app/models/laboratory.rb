class Laboratory < ActiveRecord::Base
  attr_accessible :email, :municipality_id, :name, :phone, :uid
  belongs_to :municipality
  has_many :cases
  validates_presence_of :name


  def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:uid => row['ID'])
      if existing.count == 0

        import = self.new
        import.uid = row['ID']
        import.name = row['labName']
        import.municipality_id = row['location']
        import.phone = row['phone']
        import.email = row['email']

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
