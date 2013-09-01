class He < ActiveRecord::Base
  attr_accessible :center_id, :chief_id, :code, :name, :nurse_id, :uid
  belongs_to :center
  has_many :cases
  validates_presence_of :name

  def nurse
    User.find(self.nurse_id)
  end

  def chief
    User.find(self.chief_id)
  end

  def self.import(data)
    imported = 0
    data.each do |row|
      existing = self.where(:uid => row['ID'])
      if existing.count == 0

        import = self.new
        import.uid = row['ID']
        import.code = row['code']
        if row['dz']
          center_id = Center.where(:uid => row['dz']).first
          if center_id && center_id.id
            import.center_id = center_id.id
          end
        end
        import.name = row['hesName']

        if row['chief']
          user_id = User.where(:uid => row['chief']).first
          if user_id && user_id.id
            import.chief_id = user_id.id
          end
        end

        if row['nurse']
          user_id = User.where(:uid => row['nurse']).first
          if user_id && user_id.id
            import.nurse_id = user_id.id
          end
        end

        if row['dataClerk']
          user_id = User.where(:uid => row['dataClerk']).first
          if user_id && user_id.id
            import.dataclerk_id = user_id.id
          end
        end

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
