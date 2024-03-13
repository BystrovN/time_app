require_relative 'middleware/logger'
require_relative 'time_app'

ROUTES = {
  '/time' => TimeApp.new
}.freeze

use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(ROUTES)
