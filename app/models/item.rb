class Item < ApplicationRecord
  CATEGORY  = [
    "Gardening Tools",
    "Sports Equipment",
    "DIY Tools",
    "Camping Gear",
    "Kitchen Appliances",
    "Cleaning Equipment",
    "Games and Toys",
    "Party Supplies",
    "Reading and Study Materials",
    "Transportation Equipment"
  ]
  
  belongs_to :user
  has_many :reservations, dependent: :destroy
has_one_attached :photo
  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :description, presence: true
end
