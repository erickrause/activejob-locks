module ActiveJob
  module Locks

    module Configuration
      extend ActiveSupport::Concern

      module ClassMethods
        mattr_reader(:locks) { ActiveSupport::OrderedOptions.new }
        mattr_accessor(:redis)

        def locks=(options)
          options.each { |k,v| send("#{k}=", v) }
        end

      end

    end
  end
end
