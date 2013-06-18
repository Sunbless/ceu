#encoding: utf-8
class Case < ActiveRecord::Base
  attr_accessible :age, :agent_id, :comment, :date_death, :date_entry, :date_lab, :date_of_birth, :date_of_dg, :date_report, :dg_syndrom, :district_id, :he_id, :jmbg, :labconfirmed, :laboratory_id, :operator_id, :patient_name, :patient_surname, :phi_id, :protocol, :sex, :user_id, :vaccin
  belongs_to :district
  belongs_to :user
  belongs_to :phi
  belongs_to :laboratory
  belongs_to :agent
  has_one :icd
  validates_presence_of :protocol
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

end
