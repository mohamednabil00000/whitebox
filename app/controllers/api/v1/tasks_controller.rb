# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::BaseController

	#POST /tasks
	def create
		result = task_service.create(task_params.merge!(created_by: @current_user))
		if result.successful?
			render json: result.attributes[:task], status: :created
		else
			render json: result.attributes[:errors], status: :unprocessable_entity
		end
	end

	#GET /tasks/{id}
	def show
		result = task_service.get(params[:id])
		if result.successful?
			render json: result.attributes[:task], status: :ok
		else
			# later we can introduce I18n
			render json: result.attributes[:errors], status: :not_found
		end
	end

	#POST /tasks/:task_id/users/:user_id
	def assign_user
		result = task_service.assign_user(task_id: params[:task_id], user_id: params[:user_id])
		if result.successful?
			head :no_content
		else
			render json: result.attributes[:errors], status: :bad_request
		end
	end

	#DELETE /tasks/:task_id/remove_assign
	def remove_assigning_user
		result = task_service.remove_assigning_user(task_id: params[:task_id])
		if result.successful?
			head :no_content
		else
			render json: result.attributes[:errors], status: :bad_request
		end
	end

  private
		def task_params
			params.fetch(:task, {})
						.permit(:title, :description, :estimated_points, :assignee_id, :project_id)
		end

		def task_service
			@task_service ||= V1::TaskService.new
		end
end
