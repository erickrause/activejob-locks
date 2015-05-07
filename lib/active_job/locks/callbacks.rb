require 'redlock'
module ActiveJob
  module Locks
    module Callbacks
      extend ActiveSupport::Concern
      included do
        private

        def redis_lock
          @redis_lock ||= Redlock::Client.new(redis)
        end

        def payload_key(payload)
          return nil unless payload_lock
          payload.flat_map do |argument|
            argument.respond_to?(:to_global_id) ? argument.to_global_id.uri.to_s : argument.to_s
          end
        end

        def lock_resource(payload)
          [queue_name, payload_key(payload)].join(":")
        end

        rescue_from(Exception) do |e|
          redis_lock.unlock(@my_lock) if @my_lock
          raise e
        end

        around_perform if: :lock_type do |job, block|
          if @my_lock = redis_lock.lock(lock_resource(job.arguments), ttl.to_i * 1000 )
            block.call
            redis_lock.unlock(@my_lock)
          else
            job.enqueue(wait: requeue_wait)
          end
        end

        delegate :lock_type, :queue_lock, :payload_lock, :ttl, :redis, :requeue_wait, to: :class
      end
    end
  end
end
