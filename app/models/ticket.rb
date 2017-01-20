class Ticket < ApplicationRecord

  before_validation :check_status

  validates_presence_of :created_by, :description, :severity

  validate :cancelled_reason_desc

  enum status: [:completed, :cancelled]
  enum cancelled_reason: [:others, :end_user]

  private

  def check_status
    self.cancelled_reason = nil unless self.status.eql? 'cancelled'
  end

  def cancelled_reason_desc
    self.errors.add(:base, "Please provide description for cancellation.") if ((self.cancelled_reason.eql? 'others') && self.cancelled_other_description.blank?)
  end
end
