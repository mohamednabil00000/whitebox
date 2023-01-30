require 'spec_helper'

describe UserPresenter do
	let(:user) { create :user }

	describe '#present' do
		it 'return expected user object' do
			expected_json = {
				email: user.email,
				id: user.id
			}
			expect(described_class.new.present(user: user)).to eq expected_json
		end
	end


	#TO-DO
	describe '#present_arr' do
	end
end
