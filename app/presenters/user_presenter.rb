# frozen_string_literal: true

class UserPresenter
  def initialize(user:)
    @user = user
  end

  def present
    {
      id: user.id,
      email: user.email
    }
  end

  private

  attr_reader :user
end
