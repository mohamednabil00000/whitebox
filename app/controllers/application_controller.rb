# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::MimeResponds

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    return head :unauthorized unless header

    header = header.split(' ').last
    decoded = JsonWebToken.jwt_decode(header)
    @current_user = User.find_by(id: decoded[:user_id])
    return head :unauthorized unless @current_user
  rescue JWT::ExpiredSignature, JWT::DecodeError
    head :unauthorized
  end
end
