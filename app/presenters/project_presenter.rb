# frozen_string_literal: true

#TO-DO
class ProjectPresenter
  def initialize(project:)
    @project = project
  end

  private

  attr_reader :project
end
