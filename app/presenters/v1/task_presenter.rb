# frozen_string_literal: true

class V1::TaskPresenter

  def present(task:)
    {
      id: task.id,
      title: task.title,
      description: task.description,
      assignee: task.assignee.nil? ? nil : user_presenter.present(user: task.assignee),
      created_by: user_presenter.present(user: task.created_by),
      project: project_presenter.present_summary(project: task.project)
    }
  end

  private

    def user_presenter
    	@user_presenter ||= UserPresenter.new
  	end

    def project_presenter
    	@project_presenter ||= V1::ProjectPresenter.new
  	end
end
