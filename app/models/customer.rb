class Customer < ApplicationRecord
  has_many :transactions, dependent: :destroy
  
  validates :name, presence: true
  validates :complaint, presence: true
end
