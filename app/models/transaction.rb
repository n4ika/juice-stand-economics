class Transaction < ApplicationRecord
  belongs_to :juice
  belongs_to :customer

  validates :consequence, presence: true
end
