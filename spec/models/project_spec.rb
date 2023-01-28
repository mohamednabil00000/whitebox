# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do

  describe 'associations' do
  	it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to belong_to(:user).with_foreign_key(:created_by) }
    it { is_expected.to belong_to(:leader).class_name('User') }
    it { is_expected.to have_many(:tasks) }
  end
end
