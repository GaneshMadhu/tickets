class Ticket < ApplicationRecord

  before_validation :check_status

  validates_presence_of :created_by, :description
  validates :severity, numericality: { only_integer: true }

  validate :cancelled_reason_desc

  enum status: [:completed, :cancelled]
  enum cancelled_reason: [:others, :end_user]

  private

  def check_status
    unless self.status.eql? 'cancelled'
      self.cancelled_reason = nil
      self.cancelled_other_description = ""
    end
    self.comments = "" unless self.status.eql? 'completed'
  end

  def cancelled_reason_desc
    self.errors.add(:base, "Please provide description for cancellation.") if ((self.cancelled_reason.eql? 'others') && self.cancelled_other_description.blank?)
  end
end
