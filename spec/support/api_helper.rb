# frozen_string_literal: true

require 'rails_helper'

module ApiHelper

	def set_auth_header(user_id)
		payload = {
			user_id: user_id
		}
		request.headers['Authorization'] = "Bearer #{JsonWebToken.jwt_encode(payload, exp = 7.days.from_now)}"
	end
end
