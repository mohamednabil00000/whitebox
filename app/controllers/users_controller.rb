# frozen_string_literal: true

class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	before_action :set_user, only: [:show, :destroy, :update]

	# GET /users
	def index
		render json: User.all.select(:id, :email), status: :ok
	end

	# GET /users/{id}
	def show
		result = user_service.show(user: @user)
		return head :not_found unless result.successful?

		render json: result.attributes[:user], status: :ok
	end

	#PUT /users/{id}
	def update
		result = user_service.update(user: @user, user_params: user_params)
		if result.successful?
			head :no_content
		else
			render json: result.attributes, status: :unprocessable_entity
		end
	end

	#POST /users
	def create
		result = user_service.create(user_params)
		if result.successful?
			render json: result.attributes[:user], status: :created
		else
			render json: result.attributes, status: :unprocessable_entity
		end
	end

	#DELETE /users/{id}
	def destroy
		@user.destroy
	end

  private
		def user_params
			params.fetch(:user, {}).permit(:email, :password)
		end

		def set_user
			@user = User.find_by(id: params[:id])
		end

		def user_service
			@user_service ||= UserService.new
		end
end
