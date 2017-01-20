class Ticket < ApplicationRecord
  enum status: [:completed, :cancelled]
  enum cancelled_reason: [:end_user, :others]
end
