class ChatChannel < ApplicationCable::Channel
	delegate :ablity, to: :connection
	protected :ablity

	def subscribed
		if authorize_and_set_chat
			stream_from "#{params[:team_id]}_#{params[:type]}_#{@chat}"
		end
	end

	def receive(data)
		@message = Message.new(body: data["message"], user: current_user)
		@record.messages << @message
	end

	private

	def authorize_and_set_chat
		if params[:type] == "channels"
			@record = Channel.find(params[:id])
		elsif params[:type] == "talks"
			@record = Talk.find_by(user_one_id: [params[:id], current_user.id],
								   user_one_id: [params[:id], current_user.id],
								   team: params[:team_id])
		end
		@chat = @record.id
		(ablity.can? :read, @record)? true : false
	end
end
