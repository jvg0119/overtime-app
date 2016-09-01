class AuditLog < ActiveRecord::Base
  belongs_to :user

#  enum status: { created: 0, done: 1 }
  enum status: [ :pending , :confirmed ]

#  validates :user, :status, :start_date, presence: true
  validates_presence_of :user_id, :status, :start_date
  after_initialize :set_defaults

private

  def set_defaults
  	self.start_date ||= Date.today - 6.days
  end


end
