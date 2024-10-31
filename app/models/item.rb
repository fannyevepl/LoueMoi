class Item < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
end
