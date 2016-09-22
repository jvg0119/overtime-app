class AuditLog < ActiveRecord::Base
  belongs_to :user

#  enum status: { created: 0, done: 1 }
  enum status: [ :pending , :confirmed ]

#  validates :user, :status, :start_date, presence: true
  validates_presence_of :user_id, :status, :start_date

  after_initialize :set_defaults

  before_update :set_end_date, if: :confirmed?


private

  def set_defaults
  	self.start_date ||= Date.today - 6.days
 # 	self.end_date = start_date + 6.days#Date.today   # adding this
  end

  def set_end_date
  	self.end_date = Date.today
  end


end





