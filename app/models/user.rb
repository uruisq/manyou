class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_destroy do
    throw(:abort) if User.where(admin: true).length == 1 && self.admin?
  end
  before_update do
    throw(:abort) if User.where(admin: true).length == 1
  end

  has_many :tasks, dependent: :destroy

end
