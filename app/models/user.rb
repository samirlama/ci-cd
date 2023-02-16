class User < ApplicationRecord
  #validation
  validates :name, :address, :email, presence: true
  validates :email, uniqueness: true
end
