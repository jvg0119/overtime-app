class User < ActiveRecord::Base

  has_many :posts
  has_many :audit_logs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  PHONE_REGEX = /\d{10}/  # this allows up to 10 digits only
          # /\A[0-9]*\Z/ this works also; it allows you as many or as little only digits 

  validates :phone, presence: true, 
            format: { with: PHONE_REGEX, message: "bad format" },
            length: { is: 10 }

  def full_name
  	# first_name + last_name
  	"#{last_name}, #{first_name}" 	
  end

  # def admin? ## I think this needs to be deleted later
  #   user == "AdminUser"
  # end


end
