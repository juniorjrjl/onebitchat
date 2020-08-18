class Invite < ApplicationRecord
	belongs_to :team
	belongs_to :sender, class_name: :User
	belongs_to :recipient, class_name: :User
	enum status: [:pending, :accepted, :rejected, :disabled]
	validates_uniqueness_of :team, :sender, :status, :recipient

	def set_accepted
		if self.pending?
			self.status = :accepted
		else
			raise InviteStatusError.new('only pending invites can be accepted')
		end
	end

	def set_rejected
		if self.pending?
			self.status = :rejected
		else
			raise InviteStatusError.new('only pending invites can be rejected')
		end
	end

	def set_disabled
		if self.accepted?
			self.status = :disabled
		else
			raise InviteStatusError.new('only accepted invites can be disbaled')
		end
	end

end
