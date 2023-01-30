# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsUser, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'validations' do
    it do
      user = create :user
      project = create :project, leader_id: user.id, created_by_id: user.id
      create(:projects_user, project_id: project.id, user_id: user.id)
      is_expected.to validate_uniqueness_of(:project_id).scoped_to(:user_id).with_message('already has this user!')
    end
  end
end
