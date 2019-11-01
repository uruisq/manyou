class Task < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :user
end