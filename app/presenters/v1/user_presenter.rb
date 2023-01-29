# frozen_string_literal: true

module V1
  class UserPresenter
    def present(user:)
      {
        id: user.id,
        email: user.email
      }
    end

    def present_arr(users:)
      users.map do |user|
        present(user: user)
      end
    end
  end
end
