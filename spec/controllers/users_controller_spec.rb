# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :controller do

	describe '#create' do
		context 'return success' do
			it 'should return user' do
				expect do
					post :create, params: { user: { email: 'test@gmail.com', password: '123456' } }
				end.to change(User, :count).by(1)
				expect(response.status).to eq 201
				user = User.last
				expected_response = {
					'email' => user.email,
					'id' => user.id,
					'created_at' => user.created_at.as_json,
					'updated_at' => user.updated_at.as_json
				}
				expect(JSON.parse(response.body)).to eq expected_response
			end
		end

		context 'return failures' do
			it 'when the user exists before' do
				user = create :user, email: 'test@test.com', password: '123456'
				expect do
					post :create, params: { user: { email: user.email, password: '123456' } }
				end.not_to change(User, :count)
				expect(response.status).to eq 422
				expect(JSON.parse(response.body)['errors']).to contain_exactly 'Email has already been taken'
			end
		end
	end

	describe '#show' do
		let!(:auth_user) { create(:user) }

		before { set_auth_header(auth_user.id) }

		context 'return success' do
			it 'return user json object' do
				get :show, params: { id: auth_user.id }
				expect(response.status).to eq 200
				expected_response = {
					'email' => auth_user.email,
					'id' => auth_user.id,
					'created_at' => auth_user.created_at.as_json,
					'updated_at' => auth_user.updated_at.as_json
				}
				expect(JSON.parse(response.body)).to eq expected_response
			end
		end

		context 'return failure' do
			it 'expect 404 when the user does not exist' do
				get :show, params: { id: auth_user.id + 1 }
				expect(response.status).to eq 404
			end
		end
	end

	#to-do
	describe '#update' do
	end

	#to-do
	describe '#destroy' do
	end

	#to-do
	describe '#index' do
	end
end
