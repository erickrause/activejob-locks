require 'active_job'
module ActiveJob
  module Locks
    extend ActiveSupport::Autoload

    autoload :Configuration

    def self.configure
      yield(configuration)
    end

  end
end
