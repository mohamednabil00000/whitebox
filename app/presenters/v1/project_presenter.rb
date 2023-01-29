# frozen_string_literal: true

module V1
  class ProjectPresenter
    def present(project:)
      {
        id: project.id,
        name: project.name,
        description: project.description,
        leader: user_presenter.present(user: project.leader),
        created_by: user_presenter.present(user: project.created_by),
        users_in_project: user_presenter.present_arr(users: project.users)
      }
    end

    def present_arr(projects:)
      projects.map do |project|
        present(project: project)
      end
    end

    private

    def user_presenter
      @user_presenter ||= V1::UserPresenter.new
    end
  end
end
