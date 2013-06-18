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

end
