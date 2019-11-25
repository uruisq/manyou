class Tag < ApplicationRecord
  validates :title, presence: true, length: { maximum: 12 }

  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings
end