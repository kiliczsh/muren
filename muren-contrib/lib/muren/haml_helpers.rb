# frozen_string_literal: true

require 'muren/base'
require 'muren/capture'

module Muren
  # = Muren::HamlHelpers
  #
  # This extension provides some of the helper methods that existed in Haml 5
  # but were removed in Haml 6. To use this in your app, just +register+ it:
  #
  #   require 'muren/base'
  #   require 'muren/haml_helpers'
  #
  #   class Application < Muren::Base
  #     helpers Muren::HamlHelpers
  #
  #     # now you can use the helpers in your views
  #     get '/' do
  #       haml_code = <<~HAML
  #         %p
  #           != surround "(", ")" do
  #             %a{ href: "https://example.org/" } example.org
  #       HAML
  #       haml haml_code
  #     end
  #   end
  #
  module HamlHelpers
    include Muren::Capture

    def surround(front, back = front, &block)
      "#{front}#{_capture_haml(&block).chomp}#{back}\n"
    end

    def precede(str, &block)
      "#{str}#{_capture_haml(&block).chomp}\n"
    end

    def succeed(str, &block)
      "#{_capture_haml(&block).chomp}#{str}\n"
    end

    def _capture_haml(*args, &block)
      capture(*args, &block)
    end
  end

  helpers HamlHelpers
end
