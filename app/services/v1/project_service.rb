# frozen_string_literal: true

module V1
  class ProjectService
    def create(project_params)
      project = Project.new(project_params)
      if project.save
        ResultSuccess.new(project: project_presenter.present(project: project))
      else
        ResultError.new(errors: project.errors.full_messages)
      end
    end

    def get(id)
      @project = Project.find_by(id: id)
      return ResultError.new unless @project

      ResultSuccess.new(project: project_presenter.present(project: @project))
    end

    def add_user_to_project(project_id:, user_id:)
      project = Project.find_by(id: project_id)
      return ResultError.new(errors: 'Project is not found!') unless project

      user = User.find_by(id: user_id)
      return ResultError.new(errors: 'User is not found!') unless user

      project.users << user
      ResultSuccess.new
    rescue ActiveRecord::RecordNotUnique
      ResultError.new(errors: 'This user exists before in this project')
    end

    private

    def project_presenter
      @project_presenter ||= V1::ProjectPresenter.new
    end
  end
end
