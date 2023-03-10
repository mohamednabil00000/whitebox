# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:users).through(:projects_users) }
  	it { is_expected.to have_many(:projects_users).dependent(:delete_all) }
    it { is_expected.to belong_to(:created_by).class_name('User') }
    it { is_expected.to belong_to(:leader).class_name('User') }
    it { is_expected.to have_many(:tasks) }
  end
end
