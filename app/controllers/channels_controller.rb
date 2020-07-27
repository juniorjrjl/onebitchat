class ChannelsController < ApplicationController
	before_action :set_channel, only: [:destroy, :show]

	def create
		@channel = Channel.new(channel_params)
		authorize! :create, @channel

		respond_to do |f|
			if @channel.save
				f.json{ render :show, status: :created }
			else
				f.json{ render json: @channel.errors, status: :unprocessable_entity }
			end
		end
  	end

	def destroy
		authorize! :destroy, @channel
		#@channel.destroy

		respond_to do |f|
			f.json{ render json: true }
		end
	end

	def show
		authorize! :read, @channel
	end

	private

	def set_channel
		@channel = Channel.find(params[:id])
	end

	def channel_params
		params.require(:channel).permit(:slug, :team_id).merge(user: current_user)
	end

end
