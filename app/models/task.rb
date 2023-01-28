# frozen_string_literal: true

class Task < ApplicationRecord
	belongs_to :assignee, class_name: 'User'
	belongs_to :user, :foreign_key => :created_by
	belongs_to :project
end
