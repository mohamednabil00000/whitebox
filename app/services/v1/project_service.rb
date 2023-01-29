# frozen_string_literal: true

class V1::ProjectService

	def create(project_params)
		#TODO we need to check for users before saving them

		project = Project.new(project_params)
		if project.save
			ResultSuccess.new(project: project_presenter.present(project: project))
		else
			ResultError.new(errors: project.errors.full_messages)
		end
	end

	def get(id)
		project = Project.find_by(id: id)
		return ResultError.new(errors: ['Project is not found']) unless project

		ResultSuccess.new(project: project_presenter.present(project: project))
	end

	def add_user_to_project(project_id:, user_id:)
		projects_user = ProjectsUser.new(project_id: project_id, user_id: user_id)
		return ResultSuccess.new if projects_user.save

		ResultError.new(errors: projects_user.errors.full_messages)
	end

	def remove_user_from_project(project_id:, user_id:)
		projects_user = ProjectsUser.find_by(project_id: project_id, user_id: user_id)
		projects_user.destroy if projects_user
	end

	private

	def project_presenter
		@project_presenter ||= V1::ProjectPresenter.new
	end
end
