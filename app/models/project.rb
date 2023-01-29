# frozen_string_literal: true

class Project < ApplicationRecord
	has_many :tasks
	has_and_belongs_to_many :users
	belongs_to :leader,  class_name: 'User'
	belongs_to :created_by,  class_name: 'User'

	validates :name, uniqueness: true
end
