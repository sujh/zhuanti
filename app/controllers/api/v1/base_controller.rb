class Api::V1::BaseController < ActionController::API
  before_action :authenticate

  STATUS_CODES = {
    error: 0,
    ok: 1,
    unauthorized: 100,
    illegal_token: 101,
    auth_failed: 102,
    expired_token: 103
  }

  rescue_from Mongoid::Errors::DocumentNotFound do
    render_error(:error, "Record not found")
  end

  rescue_from JWT::VerificationError do
    render_error(:illegal_token)
  end

  rescue_from JWT::ExpiredSignature do
    render_error(:expired_token)
  end

  private

    def render_ok(data = {})
      render json: { status_code: STATUS_CODES.fetch(:ok), msg: 'ok', data: data }
    end

    def render_error(code_key = :error, msg = code_key.to_s)
      render json: { status_code: STATUS_CODES.fetch(code_key), msg: msg }
    end

    def authenticate
      auth_header = request.headers["Authorization"]
      if auth_header.present?
        token_str = auth_header.split('Bearer ').last
        @stuff_id = JwtUtils.decode_jwt_payload!(token_str)["staff_id"]
      else
        render_error(:unauthorized)
      end
    end

end
