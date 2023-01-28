# frozen_string_literal: true

#TO-DO
class TaskPresenter
  def initialize(task:)
    @task = task
  end

  private

  attr_reader :task
end
