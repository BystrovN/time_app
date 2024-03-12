require_relative 'middleware/logger'
require_relative 'time_app'

ROUTES = {
  '/time' => TimeApp.new
}.freeze

use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run Rack::URLMap.new(ROUTES)
