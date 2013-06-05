require 'v8'

module Csso
  # Utility for calling into the JavaScript runtime.
  module CallJS

    # @private
    # Wrap JavaScript invocations with uniform error handling
    #
    # @yield code to wrap
    def calljs err_cls=WrappedError
      lock do
        yield
      end
    rescue V8::JSError => e
      raise err_cls.new(e)
    end

    # @private
    # Ensure proper locking before entering the V8 API
    #
    # @yield code to wrap in lock
    def lock
      result, exception = nil, nil
      V8::C::Locker() do
        begin
          result = yield
        rescue Exception => e
          exception = e
        end
      end
      if exception
        raise exception
      else
        result
      end
    end
  end

  class WrappedError < StandardError

    # Copies over `error`'s message and backtrace
    # @param [V8::JSError] error native error
    def initialize(error)
      super(error.message)
      @backtrace = error.backtrace
    end

    # @return [Array] the backtrace frames
    def backtrace
      @backtrace
    end
  end

end