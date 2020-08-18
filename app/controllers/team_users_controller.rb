class TeamUsersController < ApplicationController
	before_action :set_team_user, only: [:destroy]

	def create
		@team_user = TeamUser.new(team_user_params)
		authorize! :create, @team_user

		respond_to do |f|
			if @team_user.save
				f.json{ render :show, status: :created }
			else
				f.json{ render json: @team_user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		authorize! :destroy, @team_user
		@team_user.destroy
		invite = Invite.find_by(status: :accepted, recipient_id: current_user.id, team_id: @team_user.team_id)
		InviteChangeStatus.new().set_disabled(invite)

		respond_to do |f|
			f.json{ render json: true}
		end
	end

	private

	def set_team_user
		@team_user = TeamUser.find_by(user_id: params[:id], team_id: params[:team_id])
	end

	def team_user_params
		user = User.find_by(email: params[:team_user][:email])
		params.require(:team_user).permit(:team_id).merge(user_id: user.id)
	end
end