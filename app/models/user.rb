class User < ApplicationRecord
  attr_accessor :password_confirmation

  validates_presence_of :email, :name, :address, :city, :state, :zip
  validates :email, uniqueness: {message: "Email is already in use."}

  validates_confirmation_of :password

  has_secure_password
end
