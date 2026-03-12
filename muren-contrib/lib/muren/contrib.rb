# frozen_string_literal: true

require 'muren/contrib/setup'

module Muren
  module Contrib
    ##
    # Common middleware that doesn't bring run time overhead if not used
    # or breaks if external dependencies are missing. Will extend
    # Muren::Application by default.
    module Common
      register :ConfigFile, 'muren/config_file'
      register :MultiRoute, 'muren/multi_route'
      register :Namespace, 'muren/namespace'
      register :RespondWith, 'muren/respond_with'

      helpers :Capture, 'muren/capture'
      helpers :ContentFor, 'muren/content_for'
      helpers :Cookies, 'muren/cookies'
      helpers :EngineTracking, 'muren/engine_tracking'
      helpers :JSON, 'muren/json'
      helpers :LinkHeader, 'muren/link_header'
      helpers :Streaming, 'muren/streaming'
      helpers :RequiredParams, 'muren/required_params'
    end

    ##
    # Other extensions you don't want to be loaded unless needed.
    module Custom
      register :Reloader, 'muren/reloader'

      helpers :HamlHelpers, 'muren/haml_helpers'
    end

    ##
    # Stuff that aren't Muren extensions, technically.
    autoload :Extension, 'muren/extension'
    autoload :TestHelpers, 'muren/test_helpers'
  end

  register Muren::Contrib::Common
end
