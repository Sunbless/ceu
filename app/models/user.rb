class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :surname, :street, :post, :phone, :user_type, :municipality_id, :specialist, :admin, :uid
  # attr_accessible :title, :body
  belongs_to :municipality
  has_many :hes
  has_many :cases
  paginates_per 50  


  def user_types
    [
      'Nije definisano',
      'Doktor',
      'Sestra',
      'Analiticar'
    ]
  end

  def show_user_type
    user_types[self.user_type] if self.user_type
  end

  def full_name
    title = self.user_type == 1 ? "Dr." : ""
    "#{title} #{self.name} #{self.surname}"
  end
end
