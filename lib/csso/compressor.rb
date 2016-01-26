module Csso
  class Compressor
    def self.call(input)
      require 'csso'
      #TODO: settings?
      #TODO: handle metadata somehow?
      {
        data: Csso.optimize(input[:data], true)
      }
    end

    # sprockets 2:

    def initialize path, &block
      @block = block
    end

    def render context, opts={}
      self.class.call({data: @block.call})[:data]
    end

    class Legacy
      def self.compress data
        Compressor.call(data: data)[:data]
      end
    end

  end
end
