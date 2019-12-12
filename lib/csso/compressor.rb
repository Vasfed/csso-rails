# frozen_string_literal: true

module Csso
  # sprockets-compatible compressor
  class Compressor
    def self.call(input)
      require 'csso'
      # TODO: settings?
      if input[:metadata] && input[:metadata][:map]
        css, map_json = Csso.optimize_with_sourcemap(
          input[:data],
          # Sprockets::PathUtils.split_subpath(input[:load_path], input[:filename])
          # sprockets seems to ignore filenames here, so we may save some mem:
          'uri'
        )

        {
          data: css,
          map: Sprockets::SourceMapUtils.combine_source_maps(input[:metadata][:map], JSON.parse(map_json))
        }
      else
        { data: Csso.optimize(input[:data], true) }
      end
    end

    # sprockets 2:

    def initialize(_path, &block)
      @block = block
    end

    def render(_context, _opts = {})
      self.class.call(data: @block.call)[:data]
    end

    # for old sprockets
    class Legacy
      def self.compress(data)
        Compressor.call(data: data)[:data]
      end
    end
  end
end
