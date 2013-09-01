#encoding: utf-8
class Case < ActiveRecord::Base
  attr_accessible :age, :agent_id, :comment, :date_death, :date_entry, :date_lab, :date_of_birth, :date_of_dg, :date_report, :dg_syndrom, :district_id, :he_id, :jmbg, :labconfirmed, :laboratory_id, :operator_id, :patient_name, :patient_surname, :phi_id, :protocol, :sex, :user_id, :vaccin, :icd_id, :center_id
  belongs_to :district
  belongs_to :user
  belongs_to :phi
  belongs_to :laboratory
  belongs_to :agent
  belongs_to :icd
  belongs_to :center
  validates_presence_of :protocol, :date_of_dg, :icd_id
  paginates_per 50

  def operator
    User.find(self.operator_id).full_name
  end

  def vaccins
    {
     1 => "Potpuno",
     2 => "Nepotpuno",
     3 => "Nije vakcinisan",
     4 => "Nepoznato"
    }
  end

  def self.search(search)
    if search
      find(:all, :conditions => ["patient_name LIKE :search or patient_surname LIKE :search", {:search => "%#{search}%"}])
    else
      find(:all)
    end
  end

  def sex_choice
    {
      'm' => "Muški",
      'f' => "Ženski"
    }
  end

  def self.import(data)
    imported = 0

    hes = Hash.new
    users = Hash.new
    icds = Hash.new

    data.each do |row|
      existing = self.where(:uid => row['ID'])
      if existing.size == 0
        import = self.new
        import.uid = row['ID']
        import.district_id = row['regionId']
        import.phi_id = row['phiId']

        if row['hesId'] && !hes[row['hesId']]
          hes_id = He.where(:uid => row['hesId']).first
          if hes_id != nil && hes_id.id
            hes[row['hesId']] = hes_id.id
            import.hes_id = hes_id.id
          end
        elsif hes[row['hesId']]
          import.hes_id = hes[row['hesId']]
        end


        if row['physitianId'] && !users[row['physitianId']]
          user_id = User.where(:uid => row['physitianId']).first
          if user_id && user_id.id
            users[row['physitianId']] = user_id.id
            import.user_id = user_id.id
          end
        elsif users[row['physitianId']]
          import.user_id = users[row['physitianId']]
        end

        import.protocol = (row['protocol'] != '') ? row['protocol'] : '-/-'

        
        if row['dgSyndrome'] && !icds[row['dgSyndrome']]
          row['dgSyndrome'].sub! 'O', '0' #wrong string in import file fix
          icd_id = Icd.where(:code => row['dgSyndrome']).first
          if icd_id && icd_id.id
            icds[row['dgSyndrome']] = icd_id.id
            import.icd_id = icd_id.id
          else
            import.icd_id = 0
          end
        elsif icds[row['dgSyndrome']]
          import.icd_id = icds[row['dgSyndrome']]
        else 
          import.icd_id = 0
        end

        if row['dateOfDg'] != nil && row['dateOfDg'] != ""
          import.date_of_dg =  Date.strptime(row['dateOfDg'].sub!(' 0:00:00',''), "%m/%d/%Y")
        else
          import.date_of_dg  = Date.new
        end

        import.labconfirmed = row['labConfirmed']
        #???? import.laboratory_id = row['dgLab'] #?
        import.date_lab = row['dateLab']
        import.laboratory_id = row['lab_id']
        import.date_report = row['dateReport']
        import.date_entry = row['dateEntry']
        import.vaccin = row['vaccin']
        import.date_death = row['dateDeath']
        import.operator_id = row['operatorId'] #probably needs mapping
        import.comment = row['comment']
        import.patient_name = row['patientName']
        import.patient_surname = row['surname']
        import.age = row['age']
        import.date_of_birth = row['date_of_birth']
        import.sex = (row['sex'].to_s == '2')? 'f' : 'm'
        import.jmbg = row['JMBG']
        import.agent_id = row['loginId'] # probably needs mapping

        if import.save
          imported += 1
        else 
          puts import.errors.inspect
        end
      end

    end

    imported

  end

end
