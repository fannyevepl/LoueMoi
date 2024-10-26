class Item < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :name, presence: true
end
