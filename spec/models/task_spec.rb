# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:created_by).class_name('User') }
    it { is_expected.to belong_to(:assignee).class_name('User').optional(:true) }
    it { is_expected.to belong_to(:project) }
  end
end
