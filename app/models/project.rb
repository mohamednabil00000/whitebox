# frozen_string_literal: true

class Project < ApplicationRecord
	has_many :tasks
	has_many :projects_users, dependent: :delete_all
	has_many :users, through: :projects_users
	belongs_to :leader,  class_name: 'User'
	belongs_to :created_by,  class_name: 'User'

	validates :name, uniqueness: true
end
