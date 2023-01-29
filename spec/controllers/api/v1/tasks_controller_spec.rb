# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TasksController, type: :controller do
	let!(:user1) { create(:user, email: 'test@test.com', password: '123456') }
	let!(:user2) { create(:user, email: 'test2@test.com', password: '123456') }
	let!(:project) { create :project, leader: user1, user_ids: [user1.id], created_by: user1 }

	before { set_auth_header(user2.id) }

	describe '#create' do
		context 'return success' do
			let(:params) do
				{
					title: 'name1',
					assignee_id: user1.id,
					created_by: user1,
					description: 'desc1',
					project_id: project.id
				}
			end

			it 'should return task' do
				expect do
					post :create, params: { task: params}
				end.to change(Task, :count).by(1)
				expect(response.status).to eq 201

				task = Task.last
				expected_response = {
					'id' => task.id,
					'description' => 'hello',
					'title' => 'name1',
					'description' => 'desc1',
					'assignee'=> {
						'id' => user1.id,
						'email' => user1.email
					},
					'created_by' => {
						'id' => user2.id,
						'email' => user2.email
					},
					'project' => {
						'id' => project.id,
						'name' => project.name,
						'description' => project.description
					}
				}
				expect(JSON.parse(response.body)).to eq expected_response
			end

			#TO-DO
			it 'when there is no assignee associated' do
			end
		end

		context 'return failures' do
			let(:params1) do
				{
					title: 'name1',
					assignee_id: user2.id,
					created_by: user1,
					description: 'desc1',
					project_id: project.id
				}
			end
			it 'when assignee does not exist in the project' do
				post :create, params: { task: params1 }
				expect(response.status).to eq 422
				expect(JSON.parse(response.body)).to match_array("User does not exist in the project that contains this task!")
			end

			#TO-DO
			it 'when the title does not exist' do
			end
		end
	end

	describe '#assign_user' do
		#TO-DO
		context 'expect success' do
			it 'when assign user to task' do
			end
		end

		context 'expect failure' do
			#TODO
			it 'when user does not exist in the project' do
			end

			#TODO
			it 'when user id does not exist n the system' do
			end
		end
	end

	describe '#remove_assigning_user' do
		#TO-DO
		context 'expect success' do
			it 'when removing assignigin user from task' do
			end
		end

		context 'expect failure' do
			#TODO
			it 'when task id does not exist n the system' do
			end
		end
	end

	describe '#show' do
		#TO-DO
		it 'should return task object' do
		end

		#TO-DO
		it 'return 404 when task id does not exist' do
		end
	end
end
