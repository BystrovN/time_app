module TimeUtils
  VALID_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def find_unknown_formats(formats)
    formats - VALID_FORMATS.keys
  end

  def format_time(time, formats)
    formatted_time = formats.map { |f| time.strftime(VALID_FORMATS[f]) }
    formatted_time.join('-')
  end
end
