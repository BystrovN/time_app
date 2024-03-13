require 'rack'
require_relative 'time_utils'

class TimeApp
  TIME_QUERY_PARAM_KEY = 'format'.freeze

  def call(env)
    request = Rack::Request.new(env)
    format_params = request.params[TIME_QUERY_PARAM_KEY]

    return response(400, "Missing query parameter - #{TIME_QUERY_PARAM_KEY}") if format_params.nil?

    result = TimeUtils.new(format_params).call
    if result.success?
      response(200, result.time)
    else
      response(400, "Unknown time format #{result.unknown_formats}")
    end
  end

  private

  def response(status, body)
    Rack::Response.new(body, status).finish
  end
end
