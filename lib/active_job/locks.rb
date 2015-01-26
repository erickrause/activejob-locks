require 'active_job'
require 'active_support/core_ext/hash/keys'
require 'active_job/locks/version'
require 'active_job/locks/railtie' if defined?(Rails)

module ActiveJob
  module Locks
    extend ActiveSupport::Autoload

    autoload :Callbacks
    autoload :Configuration
    autoload :Options
  end

  Base.send :include, Locks::Configuration
  Base.send :include, Locks::Callbacks
  Base.send :extend, Locks::Options
  ActiveSupport.run_load_hooks(:locks, self)
end
