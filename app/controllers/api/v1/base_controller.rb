module Api
  module V1
    class BaseController < ActionController::API
      STATUS_CODES = { error: 0, ok: 1}

      rescue_from Mongoid::Errors::DocumentNotFound do
        render_error("record not found")
      end

      private

      def render_ok(data = {})
        render json: { status_code: STATUS_CODES[:ok], msg: 'ok', data: data }
      end

      def render_error(msg = 'error')
        render json: { status_code: STATUS_CODES[:error], msg: msg }
      end
    end
  end
end
