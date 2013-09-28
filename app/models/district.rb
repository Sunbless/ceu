class District < ActiveRecord::Base
  attr_accessible :abbr, :centar, :code, :code_stat, :entity_id, :municipalities, :name, :name_eng, :population, :id
  belongs_to :entity
  has_many :municipalities
  has_many :centers, through: :municipalities
  has_many :hes, through: :centers
  has_many :phis
  has_many :cases
  has_many :users
  validates_presence_of :abbr, :name, :name_eng


  def self.get_by_name(name)
    if name == "FBiH"
      self.where("entity_id = 9000")
    elsif name == "RS"
      self.where("entity_id = 9100")
    elsif name == "BD"
      self.where("entity_id = 9300")
    elsif name == "MoCA"
      [
        {:id => 9000, :abbr => "FBiH"},
        {:id => 9100, :abbr => "RS"},
        {:id => 9300, :abbr => "BD"}
      ]
    end
  end

  def self.get_id_from_name(name)
    if name == "FBiH"
      return 9000
    elsif name == "RS"
      return 9100
    elsif name == "BD"
      return 9300
    else
      return false
    end
  end

  def self.region_districts(entity_id)
    rd = self.where("entity_id = #{entity_id}")
    region_districts = []
    rd.each do |d|
      region_districts.push(d.id)
    end
    return region_districts.join(',')
  end

  def self.region_population(entity_id)
    self.find_by_sql("SELECT sum(population) as population FROM districts WHERE entity_id = #{entity_id}").first.population
  end

end
