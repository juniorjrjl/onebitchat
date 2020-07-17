class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!
	include CanCan::ControllerAdditions
	rescue_from CanCan::AccessDeined do |e|
		respond_to do |f|
			f.json { head :forbidden, content_type: 'text/html' }
			f.html { redirect_to main_app.root_url, notice: e.message }
		end
	end
end
