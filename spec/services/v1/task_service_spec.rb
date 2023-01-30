require 'rails_helper'

RSpec.describe V1::TaskService, type: :model do

	let(:subject) { described_class.new }
	describe '#create' do
		let!(:user) { create :user }
		let!(:project) { create :project, leader: user, user_ids: [user.id], created_by: user }

		context 'return success' do
			let(:params) do
				{
					title: 'name1',
					assignee_id: user.id,
					created_by: user,
					description: 'desc1',
					project_id: project.id
				}
			end

			it 'expect successful' do
				expect do
					result = subject.create(params)
					expect(result).to be_successful
				end.to change(Task, :count).by(1)
			end

			it 'expect successful when the assignee_id is nil' do
				params1 = params
				params1[:assignee_id] = nil
				expect do
					result = subject.create(params1)
					expect(result).to be_successful
				end.to change(Task, :count).by(1)
			end
		end

		context 'return failure' do
			let(:params) do
				{
					title: 'name1',
					assignee_id: user.id,
					created_by: user,
					description: 'desc1',
					project_id: project.id
				}
			end

			it 'when project does not exist' do
				params1 = params
				params1[:project_id] = nil
				result = subject.create(params)
				expect(result).to_not be_successful
				expect(result.attributes[:errors]).to match_array("Project must exist")
			end

			it 'when assignee does not exist in the project' do
				params1 = params
				params1[:assignee_id] = user.id + 1
				result = subject.create(params)
				expect(result).to_not be_successful
				expect(result.attributes[:errors]).to match_array("User does not exist in the project that contains this task!")
			end
		end
	end
end
