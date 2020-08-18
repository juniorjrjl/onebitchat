class User < ApplicationRecord
	has_many :teams
	has_many :messages
	has_many :sended_invites, class_name: :Invite, foreign_key: :invite_id
	has_many :recived_invites, class_name: :Invite, foreign_key: :recipient_id
	has_many :talks, dependent: :destroy
	has_many :team_users, dependent: :destroy
	has_many :member_teams, through: :team_users, source: :team


	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable,:validatable

	def has_pending_invites
		! self.recived_invites.select{ |r| r.status == "pending"}.empty?
	end

	def my_pending_invites
		self.recived_invites.select{ |r| r.status == "pending"}
	end

	def my_teams
		self.teams + self.member_teams
	end
	
end
