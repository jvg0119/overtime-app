class User < ActiveRecord::Base

  has_many :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
  	# first_name + last_name
  	"#{last_name}, #{first_name}" 	
  end

  def admin?
    user == "AdminUser"
  end


end
