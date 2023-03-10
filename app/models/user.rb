# frozen_string_literal: true

class User < ApplicationRecord
  require "securerandom"

  has_many :projects_users, dependent: :delete_all
  has_many :projects, through: :projects_users
  has_many :tasks, foreign_key: :assignee_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :email, uniqueness: true, length: { maximum: 255 }

  def self.find_authenticated(args = {})
    user = find_by(email: args[:email])
    if user && user&.valid_password?(args[:password])
      user
    else
      return nil
    end
  end
end
