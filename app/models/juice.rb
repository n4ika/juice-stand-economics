class Juice < ApplicationRecord
  has_many :transactions, dependent: :destroy
  attribute :scarcity_level, :integer, default: 0
  
  validates :flavor, presence: true, uniqueness: true
  validates :price,  presence: true,
                     numericality: { greater_than: 0 }
end
