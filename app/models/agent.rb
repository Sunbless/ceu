class Agent < ActiveRecord::Base
  attr_accessible :agent, :uid, :id
  has_many :cases
  validates_presence_of :agent

  def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:uid => row['ID'])
      if existing.size == 0
        imported += 1
        import = self.new
        import.uid = row['ID']
        import.agent = row['Agent']
        import.save
      end

    end

    imported;

  end

end
