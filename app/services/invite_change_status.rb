class InviteChangeStatus

    def set_rejected(invite)
        begin
            invite.set_rejected
            invite.save
        rescue InviteStatusError => ex
            message = ex.message
        end
    end

    def set_disabled(invite)
        begin
            invite.set_disabled
            invite.save
        rescue InviteStatusError => ex
            message = ex.message
        end
    end

    def set_accepted(invite, current_user_id)
        begin
            ActiveRecord::Base.transaction do
                team_user = TeamUser.new(user_id: current_user_id, team_id: invite.team.id)
                team_user.save
                invite.set_accepted
                invite.save
            end
        rescue InviteStatusError => ex
            message = ex.message
        end
    end

end