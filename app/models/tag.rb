class Tag < ApplicationRecord
  validates :title, presence: true

  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings
end