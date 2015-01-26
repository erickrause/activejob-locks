require 'global_id/railtie'
require 'active_job/locks'

module ActiveJob
  module Locks
    # = Active Job Railtie
    class Railtie < Rails::Railtie # :nodoc:
      config.active_job.locks = ActiveSupport::OrderedOptions.new
    end
  end
end
