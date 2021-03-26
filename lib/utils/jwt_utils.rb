require 'jwt'

module JwtUtils
  DURATION = 7.days
  HMAC_SECRET = "e6dc238d"

  def self.generate_jwt(staff_id, staff_real_name)
    payload = {
      staff_id: staff_id,
      staff_real_name: staff_real_name,
      iss: 'nbd',
      iat: Time.now.to_i,
      exp: (Time.now + DURATION).to_i
    }

    JWT.encode payload, HMAC_SECRET, 'HS256', {typ: 'JWT'}
  end

  def self.decode_jwt!(token)
    JWT.decode token, HMAC_SECRET, true, { verify_iat: true, algorithm: 'HS256' }
  end

  def self.decode_jwt_payload!(token)
    decode_jwt!(token).first
  end
end