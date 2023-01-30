# frozen_string_literal: true

class ProjectsUser < ApplicationRecord
	belongs_to :project
	belongs_to :user

	validates_uniqueness_of :project_id, scope: :user_id, :message => "already has this user!"
end
