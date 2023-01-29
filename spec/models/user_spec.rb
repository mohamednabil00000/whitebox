# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:projects) }
    it { is_expected.to have_many(:tasks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
  end
  describe '.find_authenticated' do
    context 'return success' do
      let!(:user) { create :user, email: 'test@test.com', password: '123456' }

      it 'should return user' do
        expect(described_class.find_authenticated(email: user.email, password: '123456')).to eq user
      end
    end

    context 'return failure' do
      it 'should return null when email does not exist' do
        expect(described_class.find_authenticated(email: 'fake1', password: '1234')).to eq nil
      end

      it 'should return null when email exists but password is wrong' do
        user = create :user, email: 'test@test.com', password: '123456'

        expect(described_class.find_authenticated(email: user.email, password: '1234')).to eq nil
      end
    end
  end
end
