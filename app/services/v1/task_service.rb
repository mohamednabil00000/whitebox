# frozen_string_literal: true

class V1::TaskService

	def create(task_params)
		unless is_user_in_project?(user_id: task_params[:assignee_id], project_id: task_params[:project_id])
			return ResultError.new(errors: ['User does not exist in the project that contains this task!'])
		end

		task = Task.new(task_params)

		if task.save
			ResultSuccess.new(task: task_presenter.present(task: task))
		else
			ResultError.new(errors: task.errors.full_messages)
		end
	end

	def get(id)
		task = Task.find_by(id: id)
		return ResultError.new(errors: ['Task is not found']) unless task

		ResultSuccess.new(task: task_presenter.present(task: task))
	end

	def assign_user(task_id:, user_id:)
		task = Task.find_by(id: task_id)
		return ResultError.new(errors: ['Task is not found']) unless task

		unless is_user_in_project?(user_id: user_id, project_id: task.project_id)
			return ResultError.new(errors: ['User does not exist in the project that contains this task!'])
		end

		task.assignee_id = user_id
		return ResultSuccess.new if task.save

		ResultError.new(errors: task.errors.full_messages)
	end

	def remove_assigning_user(task_id:, user_id:)
		task = Task.find_by(id: task_id)
		return ResultError.new(errors: 'Task is not found') unless task

		task.update!(assignee_id: nil) if task.assignee_id
		ResultSuccess.new
	end

	private

		def task_presenter
			@task_presenter ||= V1::TaskPresenter.new
		end

		def is_user_in_project?(user_id:, project_id:)
			return true unless user_id && project_id

			ProjectsUser.where(project_id: project_id, user_id: user_id).exists?
		end
end
