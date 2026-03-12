require 'muren/base'
require 'muren/engine_tracking'

module Muren
  #
  # = Muren::Capture
  #
  # Extension that enables blocks inside other extensions.
  # It currently works for erb, slim and haml.
  # Enables mixing of different template languages.
  #
  # Example:
  #
  #    # in hello_world.erb
  #
  #    Say
  #    <% a = capture do %>World<% end %>
  #    Hello <%= a %>!
  #
  #    # in hello_world.slim
  #
  #    | Say
  #    - a = capture do
  #      | World
  #    |  Hello #{a}!
  #
  #    # in hello_world.haml
  #
  #    Say
  #    - a = capture do
  #      World
  #      Hello #{a.strip}!
  #
  #
  # You can also use nested blocks.
  #
  # Example
  #
  #     # in hello_world.erb
  #
  #     Say
  #     <% a = capture do %>
  #       <% b = capture do %>World<% end %>
  #         <%= b %>!
  #     <% end %>
  #     Hello <%= a.strip %>
  #
  #
  # The main advantage of capture is mixing of different template engines.
  #
  # Example
  #
  #    # in mix_me_up.slim
  #
  #    - two = capture do
  #      - erb "<%= 1 + 1 %>"
  #    | 1 + 1 = #{two}
  #
  # == Usage
  #
  # === Classic Application
  #
  # In a classic application simply require the helpers, and start using them:
  #
  #     require "muren"
  #     require "muren/capture"
  #
  #     # The rest of your classic application code goes here...
  #
  # === Modular Application
  #
  # In a modular application you need to require the helpers, and then tell
  # the application you will use them:
  #
  #     require "muren/base"
  #     require "muren/capture"
  #
  #     class MyApp < Muren::Base
  #       helpers Muren::Capture
  #
  #       # The rest of your modular application code goes here...
  #     end
  #
  module Capture
    include Muren::EngineTracking

    def capture(*args, &block)
      return block[*args] if ruby?

      if haml? && Tilt[:haml] == Tilt::HamlTemplate && defined?(Haml::Buffer)
        buffer = Haml::Buffer.new(nil, Haml::Options.new.for_buffer)
        with_haml_buffer(buffer) { capture_haml(*args, &block) }
      else
        buf_was = @_out_buf
        @_out_buf = +''
        begin
          raw = block[*args]
          captured = block.binding.eval('@_out_buf')
          captured.empty? ? raw : captured
        ensure
          @_out_buf = buf_was
        end
      end
    end

    def capture_later(&block)
      engine = current_engine
      proc { |*a| with_engine(engine) { @capture = capture(*a, &block) } }
    end
  end

  helpers Capture
end
