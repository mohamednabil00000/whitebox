#frozen_string_literal: true

class User < ApplicationRecord
  require "securerandom"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def self.find_authenticated(args = {})
    user = find_by(email: args[:email])
    if user && user&.valid_password?(args[:password])
      user
    else
      return nil
    end
  end
end