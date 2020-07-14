class User < ApplicationRecord
  has_many :teams
  has_many :messages
  has_many :talks


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
end