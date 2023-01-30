# frozen_string_literal: true

class AuthenticationController < ApplicationController
	skip_before_action :authenticate_request

	#POST /auth/login
	def login
		@user = User.find_authenticated(email: params[:email], password: params[:password])
		if @user
			token = JsonWebToken.jwt_encode(user_id: @user.id)
			render json: { token: token }, status: :ok
		else
			render json: { error: I18n.t('errors.messages.unauthorized') }, status: :unauthorized
		end
	end
end
