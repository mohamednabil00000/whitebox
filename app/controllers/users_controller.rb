# frozen_string_literal: true

class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	before_action :set_user, only: [:show, :destroy, :update]

	# GET /users
	def index
		@users = User.all
		render json: @users, status: :ok
	end

	# GET /users/{id}
	def show
		return head :not_found unless @user

		render json: UserPresenter.new(user: @user).present, status: :ok
	end

	#PUT /users/{id}
	def update
		unless @user.update(user_params)
			render json: { errors: @user.errors.full_messages },
				   status: :unprocessable_entity
		end
	end

	#POST /users
	def create
		@user = User.new(user_params)
		if @user.save
			render json: UserPresenter.new(user: @user).present, status: :created
		else
			render json: { errors: @user.errors.full_messages },
				   status: :unprocessable_entity
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
end
