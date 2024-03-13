class TimeUtils
  TimeResult = Struct.new(:success?, :time, :unknown_formats)

  VALID_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(params)
    @params = params.split(',')
  end

  def call
    unknown_formats = find_unknown_formats
    TimeResult.new(
      success?: unknown_formats.empty?,
      time: unknown_formats.empty? ? format_time : nil,
      unknown_formats:
    )
  end

  private

  def find_unknown_formats
    @params - VALID_FORMATS.keys
  end

  def format_time
    time = Time.now
    formatted_time = @params.map { |f| time.strftime(VALID_FORMATS[f]) }
    formatted_time.join('-')
  end
end
