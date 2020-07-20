class TeamsController < ApplicationController
	before_action :set_team, only: [:destroy]
	before_action :set_by_slug_team, only: [:show]
	
	def index
		@teams = current_user.teams
	end

	def show
		authorize! :read, @team
	end

	def create
		@team = Team.new(team_params)

		respond_to do |f|
			if @team.save
				f.html{ redirect_to "/#{@team.slug}" }
			else
				f.html{ redirect_to main.app.root_url, notice: @team.errors }
			end
		end
	end

	def destroy
		authorize! :destroy, @team
		@team.destroy

		respond_to do |f|
			f.json{ head :no_content }
		end
	end


	private

	def set_by_slug_team
		@team = Team.find_by(slug: params[:slug])
	end

	def set_team
		@team = Team.find(params[:id])
	end

	def team_params
		params.require(:team).permit(:slug).merge(user: current_user)
	end

end
