class User < ActiveRecord::Base

  has_many :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, 
            # format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" } # with dashes
            # \d{3}\d{3}\d{4}   OK 
            format: { with: /\d{10}/, message: "bad format" }

  def full_name
  	# first_name + last_name
  	"#{last_name}, #{first_name}" 	
  end

  # def admin? ## I think this needs to be deleted later
  #   user == "AdminUser"
  # end


end
