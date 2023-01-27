# frozen_string_literal: true

require 'rails_helper'

class TestController < ApplicationController; end

RSpec.describe TestController, type: :controller do
  controller(TestController) do
    def index
      head :ok
    end
  end

  let!(:auth_user) { create(:user) }

  def make_request(params = {})
    get :index, params: params

    yield if block_given?
  end

  context 'with Authorization header authentication', type: :api do
    let!(:auth_user) { create(:user) }

    before do
      set_auth_header(auth_user.id)
    end

    it 'should return 200' do
      make_request
      expect(response.status).to eq(200)
      expect(controller.view_assigns['current_user']).to eq(auth_user)
    end
  end

  context 'without Authorization header authentication', type: :api do
    let!(:auth_user) { create(:user) }

    it 'should return unauthorized' do
      make_request
      expect(response.status).to eq(401)
    end

    it 'should return unauthorized due to user_id does not exist' do
      set_auth_header(auth_user.id + 1)
      make_request
      expect(response.status).to eq(401)
    end
  end
end
