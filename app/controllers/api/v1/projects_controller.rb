# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < Api::V1::BaseController
      # POST /projects
      def create
        result = project_service.create(project_params.merge!(created_by: @current_user))
        if result.successful?
          render json: result.attributes[:project], status: :created
        else
          render json: result.attributes[:errors], status: :unprocessable_entity
        end
      end

      # GET /projects/{id}
      def show
        result = project_service.get(params[:id])
        if result.successful?
          render json: result.attributes[:project], status: :ok
        else
          # later we can introduce I18n
          render json: { error: 'Project is not found!' }, status: :not_found
        end
      end

      # POST /projects/:project_id/users/:user_id
      def add_user
        result = project_service.add_user_to_project(project_id: params[:project_id], user_id: params[:user_id])
        if result.successful?
          head :no_content
        else
          render json: { error: result.attributes[:errors] }, status: :bad_request
        end
      end

      private

      def project_params
        params.fetch(:project, {})
              .permit(:name, :description, :leader_id, user_ids: [])
      end

      def project_service
        @project_service ||= V1::ProjectService.new
      end
    end
  end
end
