# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "faker-omniauth"
require 'test/unit'

class TestFakerOmniauth < Test::Unit::TestCase
  def setup
    @tester = Faker::Omniauth
  end

  def test_omniauth_microsoft
    auth        = @tester.microsoft
    provider    = auth[:provider]
    info        = auth[:info]
    credentials = auth[:credentials]
    raw_info    = auth[:extra][:raw_info]

    assert_equal 'entra_id', provider
    assert_instance_of String, auth[:uid]
    assert_equal 64, auth[:uid].length

    assert_equal 2, word_count(info[:name])
    assert_email_regex info[:first_name], info[:last_name], info[:email]
    assert_equal info[:name].split.first, info[:first_name]
    assert_equal info[:name].split.last, info[:last_name]
    assert_equal info[:email], raw_info[:preferred_username]
    assert_instance_of String, info[:nickname]

    assert_instance_of String, credentials[:token]
    assert_instance_of String, credentials[:refresh_token]
    assert credentials[:expires]
    assert_instance_of Integer, credentials[:expires_at]

    assert_match %r{\Ahttps://login\.microsoftonline\.com/.+/v2\.0\z}, raw_info[:iss]
    assert_equal 28, raw_info[:sub].length
    assert_equal 'client_id', raw_info[:aud]
    assert_instance_of Integer, raw_info[:exp]
    assert_instance_of Integer, raw_info[:iat]
    assert_instance_of Integer, raw_info[:nbf]

    assert_equal info[:name], raw_info[:name]
    assert_equal info[:email], raw_info[:email]
    assert_equal info[:first_name], raw_info[:given_name]
    assert_equal info[:last_name], raw_info[:family_name]

    assert_equal 32, raw_info[:tid].length
    assert_equal 32, raw_info[:oid].length
    assert_includes [true, false], raw_info[:email_verified]
  end

  def word_count(string)
    string.split.length
  end

  def assert_email_regex(first_name, last_name, email)
    sanitized_first_name = first_name&.gsub("'", '')
    sanitized_last_name = last_name&.gsub("'", '')

    regex = email_regex(sanitized_first_name, sanitized_last_name)

    assert_match(regex, email)
  end

  def email_regex(first_name, last_name)
    /(#{first_name}([_.])?#{last_name}|#{last_name}([_.])?#{first_name})@(.*)\.(example|test)/i
  end
end
