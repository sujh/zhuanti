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
        logger.info("cookie is #{request.cookies}.")
        if session_id and session_str = $redis.get(session_id)
          Marshal.load(session_str)
        else
          nil
        end
      end
    end

end
