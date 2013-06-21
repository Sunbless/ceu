class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :surname, :street, :post, :phone, :user_type, :municipality_id, :specialist, :admin, :uid, :username, :district_id
  attr_accessor :login
  attr_accessible :login
  # attr_accessible :title, :body
  belongs_to :municipality
  belongs_to :district
  has_many :hes
  has_many :cases
  paginates_per 50  


  def user_types
    [
      'Nije definisano',
      'Doktor',
      'Sestra',
      'Operater'
    ]
  end

  def show_user_type
    user_types[self.user_type] if self.user_type
  end

  def full_name
    title = self.user_type == 1 ? "Dr." : ""
    "#{title} #{self.name} #{self.surname}"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end
