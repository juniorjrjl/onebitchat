class InvitesController  < ApplicationController
    before_action :set_invite, only: [:create]
    before_action :get_invite, only: [:accept, :reject, :disable]

    def create
        @invite = Invite.new(set_invite.except(:recipient_email))
        authorize! :create, @invite

        respond_to do |f|
            if @invite.save
				f.json{ render :show, status: :created }
            else
				f.json{ render json: @invite.errors, status: :unprocessable_entity }
			end
		end
    end

    def accept
        InviteChangeStatus.new().set_accepted(@invite, current_user.id)
        redirect_to controller: :teams, action: :show, slug: @invite.team.slug
    end

    def reject
        InviteChangeStatus.new().set_rejected(@invite)
        redirect_to root_path
    end
    
    def disable
        InviteChangeStatus.new().set_disabled(@invite)
        redirect_to root_path
    end

    private

    def set_invite
        user_recipient = User.find_by(email: params[:invite][:recipient_email])
        params.require(:invite).permit(:recipient_email, :team_id)
            .merge(sender_id: current_user.id) .merge(recipient_id: user_recipient.id)
    end

    def get_invite
        @invite = Invite.find_by(id: params[:id], recipient_id: current_user.id)
    end

end