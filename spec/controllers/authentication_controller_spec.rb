# frozen_string_literal: true

require 'rails_helper'

describe AuthenticationController, type: :controller do
	let!(:user) { create(:user, email: 'test@test.com', password: '123456') }

	describe '#login' do
		context 'return success' do
			it 'should return token' do
				post :login, params: { email: user.email, password: '123456'}
				expect(response.status).to eq 200
				expect(JSON.parse(response.body).keys).to contain_exactly('token')
			end
		end

		context 'return unauthorized' do
			it 'when the password is wrong' do
				post :login, params: { email: user.email, password: '1234567'}
				expect(response.status).to eq 401
				expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
			end

			it 'when the email is wrong' do
				post :login, params: { email: 'fake@gmali.com', password: '123456'}
				expect(response.status).to eq 401
				expect(JSON.parse(response.body)['error']).to eq 'unauthorized'
			end
		end
	end
end
