class Team < ApplicationRecord
    belongd_to :user
    has_many :talks
    has_many :channels
    has_many :users, through :team_users
    validates_presence_of :slug, :user
    validates :slug, uniqueness: true, format: {with: /\A[a-zA-Z0-9]+\Z/ }
end
