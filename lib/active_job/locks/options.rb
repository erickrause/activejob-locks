module ActiveJob
  module Locks
    module Options
      extend ActiveSupport::Concern

      attr_reader(:lock_type)
      attr_reader(:queue_lock)
      attr_reader(:payload_lock)

      def lock_by(lock_type, options = {})
        @lock_type = lock_type
        @queue_lock = @lock_type == :queue
        @payload_lock = @lock_type == :payload
        @options = options
        @redis = redis
      end

      def ttl
        @options[:ttl] || 1.minute
      end

      def requeue_wait
      	@options[:requeue_wait]
      end
    end
  end
end
