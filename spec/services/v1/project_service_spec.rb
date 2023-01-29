require 'rails_helper'

RSpec.describe V1::ProjectService, type: :model do

	let(:subject) { described_class.new }
	describe '#create' do
		let!(:user) { create :user }
		context 'return success' do
			let(:params) do
				{
					name: 'name1',
					leader_id: user.id,
					created_by: user,
					description: 'desc1',
					user_ids:[user.id]
				}
			end

			it 'expect successful' do
				expect do
					result = subject.create(params)
					expect(result).to be_successful
				end.to change(Project, :count).by(1)
			end
		end

		context 'return failure' do
			let(:params) do
				{
					name: 'name1',
					leader_id: user.id,
					created_by: user,
					description: 'desc1',
					user_ids:[user.id]
				}
			end

			it 'when leader does not exist' do
				params1 = params
				params1[:leader_id] = nil
				result = subject.create(params)
				expect(result).to_not be_successful
				expect(result.attributes[:errors]).to match_array("Leader must exist")
			end

			#TODO
			it 'when user_ids contains user does not exist' do
			end

			#TODO
			it 'when name is repeated' do
			end

			#TODO
			it 'when user_ids does not exist on params' do
			end
		end
	end
end
