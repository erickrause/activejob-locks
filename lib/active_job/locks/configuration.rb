module ActiveJob
  module Locks
    class Configuration
      attr_accessor(:redis) { [Redis.current.client.options[:url]] }
      attr_accessor(:requeue_wait) { 5.seconds }
      attr_accessor(:lock_time) { 1.minute }
    end
  end
end
