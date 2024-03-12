require 'rack'
require_relative 'time_utils'

class TimeApp
  include TimeUtils

  TIME_QUERY_PARAM_KEY = 'format'.freeze
  DEFAULT_HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    request = Rack::Request.new(env)

    return [404, DEFAULT_HEADERS, ['Only GET request']] unless request.get?

    format_param = request.params[TIME_QUERY_PARAM_KEY]

    return [400, DEFAULT_HEADERS, ["Missing query parameter - #{TIME_QUERY_PARAM_KEY}"]] if format_param.nil?

    formats = format_param.split(',')
    unknown_formats = find_unknown_formats(formats)

    return [400, DEFAULT_HEADERS, ["Unknown time format #{unknown_formats}"]] unless unknown_formats.empty?

    time = Time.now
    response_body = format_time(time, formats)
    [200, DEFAULT_HEADERS, [response_body]]
  end
end
