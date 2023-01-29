# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ProjectsController, type: :controller do
	let!(:user1) { create(:user, email: 'test@test.com', password: '123456') }
	let!(:user2) { create(:user, email: 'test2@test.com', password: '123456') }

	before { set_auth_header(user2.id) }

	describe '#create' do
		context 'return success' do
			let(:params) do
				{
					name: 'name1',
					description: 'hello',
					leader_id: user1.id,
					user_ids: [user1.id, user2.id]
				}
			end

			it 'should return project' do
				expect do
					post :create, params: { project: params}
				end.to change(Project, :count).by(1)
				expect(response.status).to eq 201

				project = Project.last
				expected_response = {
					'id' => project.id,
					'description' => 'hello',
					'name' => 'name1',
					'leader'=> {
						'id' => user1.id,
						'email' => user1.email
					},
					'created_by' => {
						'id' => user2.id,
						'email' => user2.email
					},
					'users_in_project'=> [
						{
							'id' => user1.id,
							'email' => user1.email
						},
						{
							'id' => user2.id,
							'email' => user2.email
						}
					]
				}
				expect(JSON.parse(response.body)).to eq expected_response
			end

			#TO-DO
			it 'when there is no users associated' do
			end
		end

		context 'return failures' do
			let(:params1) do
				{
					name: 'name1',
					description: 'hello',
					leader_id: user1.id + user2.id,
					user_ids: [user1.id, user2.id]
				}
			end
			it 'when leader id does not exist' do
				post :create, params: { project: params1 }
				expect(response.status).to eq 422
				expect(JSON.parse(response.body)).to match_array("Leader must exist")
			end

			#TO-DO
			it 'when one of user_ids is not exist' do
			end

			#TO-DO
			it 'when the name already exist before' do
			end
		end
	end

	describe '#add_user' do
		#TO-DO
		it 'expect project has 2 users after adding a new one' do
		end

		#TO-DO
		it 'expect error when adding user does not exist' do
		end

		#TO-DO
		it 'expect error when adding project does not exist' do
		end
	end

	describe '#remove_user' do
		#TO-DO
		it 'expect project has no users after removing the only one existed' do
		end

		#TO-DO
		it 'expect 204 when removing user does not exist from existed project' do
		end

		#TO-DO
		it 'expect 204 when removing user from un-existed project' do
		end
	end

	describe '#show' do
		#TO-DO
		it 'should return project object' do
		end

		#TO-DO
		it 'return 404 when project id does not exist' do
		end
	end
end
