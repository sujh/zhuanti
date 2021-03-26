class Api::V1::TokensController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:show]

  def show
    if staff_session.present?
      token = JwtUtils.generate_jwt(staff_session["staff_id"], staff_session["staff_real_name"])
      render_ok(token: token, staff_real_name: staff_session["staff_real_name"])
    else
      render_error(:auth_failed)
    end
  end

  private

    def staff_session
      @session ||= begin
        session_id = request.cookies["_nbd_session_id"]
        return if session_id.nil?
        Marshal.load($redis.get(session_id)) rescue nil
      end
    end

end
