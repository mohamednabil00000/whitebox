# frozen_string_literal: true

class Project < ApplicationRecord
	has_many :tasks
	has_and_belongs_to_many :users
	belongs_to :leader,  class_name: 'User'
	belongs_to :user, :foreign_key => :created_by
end
