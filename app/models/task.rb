# frozen_string_literal: true

class Task < ApplicationRecord
	belongs_to :assignee, class_name: 'User'
	belongs_to :created_by, class_name: 'User'
	belongs_to :project
end
