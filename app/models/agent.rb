class Agent < ActiveRecord::Base
  attr_accessible :agent, :uid, :id
  has_many :cases
  validates_presence_of :agent
end
