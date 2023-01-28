require 'spec_helper'

describe UserPresenter do
	let(:user) { create :user }

	let(:subject) { described_class.new(user: user) }

	describe '#present' do
		it 'return expected user object' do
			expected_json = {
				email: user.email,
				id: user.id
			}
			expect(subject.present).to eq expected_json
		end
	end
end
