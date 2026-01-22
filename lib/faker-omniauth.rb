# frozen_string_literal: true

require 'faker'

module Faker
  class Omniauth < Base
    class << self
      ##
      # Generate a mock Omniauth response from Microsoft Entra ID (Azure AD).
      #
      # @param name [String] A specific name to return in the response.
      # @param email [String] A specific email to return in the response.
      # @param uid [String] A specific UID to return in the response.
      #
      # @return [Hash] An auth hash in the format provided by omniauth-entra-id.
      def microsoft(provider: 'entra_id', name: nil, email: nil, uid: nil)
        auth = Omniauth.new(name: name, email: email)
        tenant_id = Number.hexadecimal(digits: 32)
        object_id = Number.hexadecimal(digits: 32)
        uid ||= tenant_id + object_id
        {
          provider: provider,
          uid: uid,
          info: {
            name: auth.name,
            email: auth.email,
            nickname: auth.name.downcase.tr(' ', '.'),
            first_name: auth.first_name,
            last_name: auth.last_name
          },
          credentials: {
            token: Crypto.md5,
            refresh_token: Crypto.md5,
            expires_at: Time.forward.to_i,
            expires: true
          },
          extra: {
            raw_info: {
              iss: "https://login.microsoftonline.com/#{tenant_id}/v2.0",
              sub: Number.hexadecimal(digits: 28),
              aud: 'client_id',
              exp: Time.forward.to_i,
              iat: Time.forward.to_i,
              nbf: Time.forward.to_i,
              name: auth.name,
              preferred_username: auth.email,
              oid: object_id,
              tid: tenant_id,
              email: auth.email,
              email_verified: random_boolean,
              given_name: auth.first_name,
              family_name: auth.last_name
            }
          }
        }
      end
    end
  end
end
